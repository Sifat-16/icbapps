import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/MainAdminModel.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  FireBase fireBase = FireBase();
  TextEditingController amount = TextEditingController();
  TextEditingController transactionId = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recharge"),
      ),
      body: Column(
        children: [
          StreamBuilder<MainAdminModel>(
            stream: fireBase.mainadmindatas(),
            builder: (context, snapshot) {
              return snapshot.hasData?Text("Send Money to this number ${snapshot.data!.bkashnumber}"):CircularProgressIndicator();

            }
          ),
          TextField(
            controller: amount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),

          ),

          TextField(
            controller: transactionId,
            decoration: InputDecoration(
                border: OutlineInputBorder()
            ),

          ),

          TextButton(onPressed: (){
            fireBase.rechargeTobalance(amount.text.trim(), transactionId.text.trim()).then((value){
              print(value);
            });

          }, child: Text("Send request"))

        ],
      ),
    );
  }
}
