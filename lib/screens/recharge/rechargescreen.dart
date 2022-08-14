import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';

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
          Text("Send Money to this number 01999999999"),
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
