import 'package:flutter/material.dart';
import 'package:icbapps/screens/recharge/rechargescreen.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Others"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: (){

          }, child: Text("Cash Transfer")),
          TextButton(onPressed: (){

          }, child: Text("Update app")),
          TextButton(onPressed: (){

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RechargeScreen()));

          }, child: Text("Recharge")),
          TextButton(onPressed: (){

          }, child: Text("Message")),
        ],
      ),
    );
  }
}
