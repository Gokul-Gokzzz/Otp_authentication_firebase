import 'dart:io';

import 'package:authentication/controller/auth_provider.dart';
import 'package:authentication/model/user_model.dart';
import 'package:authentication/view/home_screen.dart';
import 'package:authentication/view/widget/custom_button.dart';
import 'package:authentication/view/widget/snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  File? image;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
  }

  Future<void> pickImage() async {
    // Corrected return type
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          image = File(pickedImage.path);
        });
      }
    } catch (e) {
      showSnakBar(context, e.toString()); // Corrected function name
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthenProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                  child: Center(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: pickImage, // Corrected function call
                          child: image == null
                              ? const CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  radius: 50,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: 50,
                                ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              textField(
                                hintText: "john",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLine: 1,
                                controller: nameController,
                              ),
                              textField(
                                hintText: "abc@gmail.com",
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                maxLine: 1,
                                controller: emailController,
                              ),
                              textField(
                                hintText: "Enter your bio here....",
                                icon: Icons.edit,
                                inputType: TextInputType.name,
                                maxLine: 2,
                                controller: bioController,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: CustomButton(
                            text: 'Continue',
                            onPressed: () => storeData(),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLine,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLine,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.purple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  void storeData() async {
    final authenProvider = Provider.of<AuthenProvider>(context, listen: false);
    var newUser = UserModel(
      // Assigning UserModel to a variable
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      bio: bioController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    if (image != null) {
      authenProvider.saveUserData(
        context: context,
        userModel: newUser,
        profilePic: image!,
        onSuccess: () {
          authenProvider.saveUserDataSp().then((value) => authenProvider
              .setSignIn()
              .then((value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  )));
        },
      );
    } else {
      showSnakBar(context, "Please upload your photo");
    }
  }
}
