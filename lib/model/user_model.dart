class UserModel {
  String name;
  String email;
  String bio;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;

  UserModel(
      {required this.name,
      required this.email,
      required this.bio,
      required this.profilePic,
      required this.createdAt,
      required this.phoneNumber,
      required this.uid});

  factory UserModel.fromjson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      bio: map['bio'] ?? "",
      uid: map['uid'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      createdAt: map['createdAt'] ?? "",
      profilePic: map['profilePic'] ?? "",
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'email': email,
      'bio': bio,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'profilePic': profilePic,
    };
  }
}
