import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/view/chat/constants.dart';
import 'package:ows_bigcareer/view/chat/models/models.dart';

class ChatViewModel with ChangeNotifier {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  ChatViewModel({required this.firebaseFirestore, required this.firebaseStorage});

  Stream<QuerySnapshot> getChats(
      String pathName,String uid, int limit, String? textSearch) {
    print('getUsersChats----pathName:${pathName}----uid :${uid}----');
    return firebaseFirestore
        .collection(pathName)
        .doc(uid)
        .collection(uid)
        .limit(limit)
        .snapshots();
    // HireByMe
  }

  Future<UserChat> getUserDetails(String uid) async {
    DocumentSnapshot? snapshot;
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .get()
        .then((docSnapshot) {
      snapshot = docSnapshot;
      print('getUserDetails2--------uid :${snapshot}----');
      print(docSnapshot.data());
      print(docSnapshot['name']);
      print(docSnapshot['image']);
    });
    return _userDataFromSnapshot(snapshot!);
  }

  UserChat _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserChat(
      mobile: snapshot['mobile'],
      image: snapshot['image'],
      name: snapshot['name'],
      email: snapshot['email'],
      pwd: snapshot['pwd'],
      uid: snapshot['uid'],
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((doc) => print('----${doc}'));
  }

  Stream<QuerySnapshot> getStreamFireStore(
      String pathCollection, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .where('name', isEqualTo: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .snapshots();
    }
  }

  Future<void> updateDataFireStore(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(dataNeedUpdate);
  }





  UploadTask uploadFile(File image, String fileName) {
    Reference reference = firebaseStorage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    notifyListeners();
    return uploadTask;
  }

  Stream<QuerySnapshot> getChatStream(String collectionName,String groupChatId, int limit) {
    print('--getChatStream-:${collectionName}------------');
    return firebaseFirestore
        .collection(collectionName)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }
  void sendMessage(String primary,String secondary1,String secondary2,String content, int type, String groupChatId, String currentUserId, String peerId, bool firstTime) {
    print('sendMessage-----primary:$primary----secondary1:$secondary1----secondary2:$secondary2-----$peerId');
    DocumentReference documentReference = firebaseFirestore
        .collection(primary)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    MessageChat messageChat = MessageChat(
      idFrom: currentUserId,
      idTo: peerId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: type,
    );
    if(firstTime==true){
      FirebaseFirestore.instance
          .collection(secondary1).doc(currentUserId).collection(currentUserId).doc(peerId).set({
        'name': peerId,
        'imageUrl': "CA",
        'nickname': "USA"
      });
      FirebaseFirestore.instance
          .collection(secondary2).doc(peerId).collection(peerId).doc(currentUserId).set({
        'name': "sab$currentUserId",
        'imageUrl': "CA",
        'nickname': "USA"
      });
    }
    else{
    }
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }
}
