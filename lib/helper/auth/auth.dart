import 'dart:io';
import 'dart:math';

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

  createProfile(ModelUser modelUser, String refarral)async{
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    modelUser.refarralId = String.fromCharCodes(Iterable.generate(6, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    final x = await store.collection("userProfile").doc(modelUser.uid).set(modelUser.toJson()).onError((error, stackTrace) => false);

    return true;

  }

  Future<ModelUser>myProfile()async{
    ModelUser modelUser = ModelUser();
    final x = await store.collection("userProfile").doc(auth.currentUser!.uid).get().then((value) {
      modelUser = ModelUser.fromJson(value.data()!);
    });

    print(modelUser.username);
    return modelUser;

  }

  addRefaralToTeam(ModelUser modelUser, String refarral) async{

    if(refarral==null||refarral.length<6){

    }else{

      try{
        final y = await store.collection("userProfile").where("refarralId", isEqualTo: refarral).get().then((value) async{
          print(value.docs.length);
          final z = store.collection("userProfile").doc(value.docs.first.data()["uid"]);
          final l = await z.get();
          print(l.data()!["teamMember"]);
          List<String> x =[];
          double point = 0;
          if(l.data()!["teamMember"]!=null){
            l.data()!["teamMember"].forEach((e){
              x.add(e);
            });
            x.add(modelUser.uid!);
          }
          if(l.data()!["balance"]!=null){
            point=l.data()!["balance"];
            point+=500;
          }
          final k = await z.update({
            "teamMember":x,
            "balance":point
          });
        });
      }catch(e){
        print("went wrong");
      }


    }

  }



}