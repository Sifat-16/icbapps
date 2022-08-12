import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/ModelUser.dart';
import 'package:icbapps/screens/loginorsignup/loginorsignup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ModelUser modelUser = ModelUser();
  //FireBase fireBase = FireBase();

  @override
  void initState() {
    //fireBase.myProfile();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: ()async{

              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginOrSignup()));
              });

            }, icon: Icon(Icons.logout))
          ],
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Container1(),
            Container2(),
            Container3()




          ],
        ),

      ),
    );
  }
}

class Container1 extends StatefulWidget {
  const Container1({Key? key}) : super(key: key);

  @override
  State<Container1> createState() => _Container1State();
}

class _Container1State extends State<Container1> {
  FireBase fireBase=FireBase();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FutureBuilder<ModelUser>(
          future: fireBase.myProfile(),
          builder: (context, snapshot) {

            return snapshot.hasData?Container(
              height: 100,
              width: MediaQuery.of(context).size.width*.5,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: ListTile(
                  title: Text("ID Name: ${snapshot.data?.fullName}"),
                  leading: snapshot.data?.profileImage==null?CircleAvatar():CircleAvatar(backgroundImage: NetworkImage("${snapshot.data?.profileImage}"),),
                  subtitle: Text("username: ${snapshot.data?.username}"),
                ),
              ),
            ):CircularProgressIndicator();
          }
        ),
        GestureDetector(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width*.25,
            decoration: BoxDecoration(
              color: Colors.lightBlue.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Center(child: Text("View Profile")),
          ),
        )
      ],
    );
  }
}
class Container2 extends StatefulWidget {
  const Container2({Key? key}) : super(key: key);

  @override
  State<Container2> createState() => _Container2State();
}

class _Container2State extends State<Container2> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){}, child: Text("Daily work")),
              TextButton(onPressed: (){}, child: Text("Select Package")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){}, child: Text("History")),
              TextButton(onPressed: (){}, child: Text("Registration")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){}, child: Text("Withdraw")),
              TextButton(onPressed: (){}, child: Text("Others")),
            ],
          ),

        ],
      ),

    );
  }
}

class Container3 extends StatefulWidget {
  const Container3({Key? key}) : super(key: key);

  @override
  State<Container3> createState() => _Container3State();
}

class _Container3State extends State<Container3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginOrSignup()));
            });
          }, child: Text("Log out")),
          ElevatedButton(onPressed: (){}, child: Text("Edit profile")),
        ],
      ),
    );
  }
}



