import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

class UserChat {
  String mobile;
  String image;
  String name;
  String email;
  String pwd;
  String uid;

  UserChat({
    required this.mobile,
    required this.image,
    required this.name,
    required this.email,
    required this.pwd,
    required this.uid,
  });

  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickname: name,
      FirestoreConstants.aboutMe: email,
      FirestoreConstants.photoUrl: image,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    String mobile = "";
    try {
      aboutMe = doc.get('email');
    } catch (e) {}
    try {
      aboutMe = doc.get('mobile');
    } catch (e) {}
    try {
      photoUrl = doc.get('image');
    } catch (e) {}
    try {
      nickname = doc.get('name');
    } catch (e) {}
    return UserChat(
      name: nickname,
      mobile: mobile,
      pwd: mobile,
      email: aboutMe,
      image: photoUrl,
      uid: mobile,
    );
  }
}
