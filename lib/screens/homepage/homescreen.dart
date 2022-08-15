import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/ModelUser.dart';
import 'package:icbapps/screens/dailywork/dailyworkscreen.dart';
import 'package:icbapps/screens/history/historyscreen.dart';
import 'package:icbapps/screens/homepage/whatsappsend.dart';
import 'package:icbapps/screens/loginorsignup/loginorsignup.dart';
import 'package:icbapps/screens/others/adminmainscreen.dart';
import 'package:icbapps/screens/others/otherscreen.dart';
import 'package:icbapps/screens/registration_int/registrationscreen.dart';
import 'package:icbapps/screens/withdrawcash/withdrawcashscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ModelUser modelUser = ModelUser();
  FireBase fireBase = FireBase();

  @override
  void initState() {
    fireBase.checkPresenceAndCreate();
    //fireBase.myProfile();
    /*fireBase.myProfileStream().listen((event) {
      print(event.username);
    });
    fireBase.myProfile().then((value) {
      this.setState(() {
        modelUser = value;
      });
    });*/
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

        body: StreamBuilder<ModelUser>(
          stream: fireBase.myProfileStream(),
          builder: (context, snapshot) {
           // print(snapshot.data!.lastWithdraw);

            if(snapshot.hasData){
              if(snapshot.data?.username=="siftan10203099"){
                return MainAdminScreen();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container1(modelUser: snapshot.data!,),
                  Container2(modelUser: snapshot.data!,),
                  Container3(modelUser: snapshot.data!,)
                ],
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }

            return snapshot.hasData?Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container1(modelUser: snapshot.data!,),
                Container2(modelUser: snapshot.data!,),
                Container3(modelUser: snapshot.data!,)
              ],
            ):Center(child: CircularProgressIndicator(),);
          }
        ),

      ),
    );
  }
}

class Container1 extends StatefulWidget {
  Container1({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;

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
        Container(
              height: 100,
              width: MediaQuery.of(context).size.width*.5,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: ListTile(
                  title: Text("ID Name: ${widget.modelUser.fullName}"),
                  leading: widget.modelUser.profileImage==null?CircleAvatar():CircleAvatar(backgroundImage: NetworkImage("${widget.modelUser.profileImage}"),),
                  subtitle: Text("username: ${widget.modelUser.username}"),
                ),
              ),
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
  Container2({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;

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
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DailyWork(modelUser: widget.modelUser,)));

              }, child: Text("Daily work")),
              TextButton(onPressed: ()async{

                await openwhatsapp(context);

              }, child: Text("Message")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HistoryScreen(modelUser: widget.modelUser,)));
              }, child: Text("History")),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Registration(modelUser: widget.modelUser)));

              }, child: Text("Registration")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WithdrawCashScreen(modelUser: widget.modelUser)));
              }, child: Text("Withdraw")),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtherScreen()));
              }, child: Text("Others")),
            ],
          ),

        ],
      ),

    );
  }
}

class Container3 extends StatefulWidget {
  Container3({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;

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



