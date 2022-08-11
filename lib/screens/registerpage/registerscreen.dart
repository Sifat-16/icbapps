import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/ModelUser.dart';
import 'package:icbapps/screens/homepage/homescreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController refarralid = TextEditingController();
  TextEditingController password = TextEditingController();
  File? imagefile;
  String? fileName;
  FireBase fireBase = FireBase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: ()async{
                final result = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ["png", "jpg"]
                );
                String? path = result?.files.single.path;
                String? name = result?.files.single.name;
                this.setState(() {
                  imagefile = File(path!);
                  fileName = name;
                  print(imagefile!.path);
                });


              },
              child: CircleAvatar(
                radius: 40,
              ),
            ),

            TextField(
              controller: username,
              decoration: InputDecoration(
                  hintText: "username",
                  border: OutlineInputBorder()
              ),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                  hintText: "email",
                  border: OutlineInputBorder()
              ),
            ),
            TextField(
              controller: fullname,
              decoration: InputDecoration(
                  hintText: "fullname",
                  border: OutlineInputBorder()
              ),
            ),
            TextField(
              controller: country,
              decoration: InputDecoration(
                  hintText: "country",
                  border: OutlineInputBorder()
              ),
            ),
            TextField(
              controller: refarralid,
              decoration: InputDecoration(
                  hintText: "refarral id",
                  border: OutlineInputBorder()
              ),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder()
              ),
            ),

            ElevatedButton(onPressed: ()async{

              UserCredential x = await fireBase.signup(username.text.trim()+"@gmail.com", password.text.trim());

              if(x!=null){
                ModelUser modelUser = ModelUser(username: username.text.trim(), email: email.text.trim(),fullName: fullname.text.trim(), country: country.text.trim(), refarralId: refarralid.text.trim(), uid: x.user!.uid);
                if(imagefile!=null){
                  final profileImage = await fireBase.uploadImage(imagefile!, fileName!);
                  modelUser.profileImage=profileImage;
                }
                final c = await fireBase.createProfile(modelUser);
                if(c==true){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
                }

              }






            }, child: Text("Create"))

          ],
        ),
      ),

    );
  }
}
