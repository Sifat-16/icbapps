import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:icbapps/models/ModelUser.dart';

class FireBase{
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final store = FirebaseFirestore.instance;

  Future<UserCredential> signin(String username, String password)async{
    final x = await auth.signInWithEmailAndPassword(email: username, password: password);
    return x;
  }

  Future<UserCredential>signup(String username, String password)async{
    final x = await auth.createUserWithEmailAndPassword(email: username, password: password);
    return x;
  }

  Future<String> uploadImage(File imageFile, String fileName) async{
    final x = await storage.ref("profile/$fileName").putFile(imageFile);
    final y = await x.ref.getDownloadURL();
    return y;
  }

  createProfile(ModelUser modelUser)async{
    final x = await store.collection("userProfile").doc(modelUser.uid).set(modelUser.toJson()).onError((error, stackTrace) => false);
    return true;

  }



}