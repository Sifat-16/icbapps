import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/screens/loginorsignup/loginorsignup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{

            await FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginOrSignup()));
            });

          }, icon: Icon(Icons.logout))
        ],
      ),

    );
  }
}
