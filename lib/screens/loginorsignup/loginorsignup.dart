import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/screens/homepage/homescreen.dart';
import 'package:icbapps/screens/registerpage/registerscreen.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({Key? key}) : super(key: key);

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  FireBase fireBase = FireBase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder()
              ),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                hintText: "password",
                  border: OutlineInputBorder()
              ),
            ),

            ElevatedButton(onPressed: ()async{

              final x = await fireBase.signin(username.text.trim()+"@gmail.com", password.text.trim());
              if(x!=null){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
              }

            }, child: Text("Sign In")),

            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterScreen()));

            }, child: Text("Sign Up"))

          ],
        ),
      ),
    );
  }
}
