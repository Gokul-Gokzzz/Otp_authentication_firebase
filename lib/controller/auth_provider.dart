import 'dart:convert';
import 'dart:io';

import 'package:authentication/model/user_model.dart';
import 'package:authentication/view/otp_screen.dart';
import 'package:authentication/view/user_info_screen.dart';
import 'package:authentication/view/widget/snak_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthenProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences prefer = await SharedPreferences.getInstance();
    _isSignedIn = prefer.getBool('is_signedin') ?? false;
    notifyListeners();
  }

  setSignIn() async {
    final SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpScreen(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (verification) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnakBar(context, e.message.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp,
      );
      await _firebaseAuth.signInWithCredential(creds);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const UserInfoScreen()),
          (route) => false);
      // if (_uid != null) {
      //   _uid = user.uid;

      //   // onSuccess();
      // }
    } on FirebaseAuthException catch (e) {
      showSnakBar(context, e.message.toString());
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (_firebaseAuth.currentUser!.uid.isNotEmpty && snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print('NEW USER');
      return false;
    }
  }

  void saveUserData({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      String profilePicUrl = await storeFile("profilePic/$_uid", profilePic);
      userModel.profilePic = profilePicUrl;
      userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      userModel.uid = _firebaseAuth.currentUser!.uid;
      _userModel = userModel;

      await _firebaseFirestore
          .collection("user")
          .doc(_uid)
          .set(userModel.tojson())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnakBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFile(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
          name: snapshot['name'],
          email: snapshot['email'],
          bio: snapshot['bio'],
          profilePic: snapshot['profilPic'],
          createdAt: snapshot['createdAt'],
          phoneNumber: snapshot['phoneNumber'],
          uid: snapshot['uid']);
      _uid = userModel.uid;
    });
  }

  saveUserDataSp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("user_model", jsonEncode(userModel.tojson()));
  }

  Future getDataSp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String data = preferences.getString("user_model") ?? "";
    _userModel = UserModel.fromjson(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    preferences.clear();
  }
}
