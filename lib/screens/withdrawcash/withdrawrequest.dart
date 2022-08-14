import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/ModelUser.dart';
import 'package:icbapps/models/WithdrawModel.dart';

class WithDrawRequest extends StatefulWidget {
  WithDrawRequest({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;

  @override
  State<WithDrawRequest> createState() => _WithDrawRequestState();
}

class _WithDrawRequestState extends State<WithDrawRequest> {
  TextEditingController number = TextEditingController();
  TextEditingController amount = TextEditingController();
  bool canWithdraw = false;
  bool result = false;
  bool processing = false;
  FireBase fireBase = FireBase();

  @override
  void initState() {
    // TODO: implement initState
    //print(widget.modelUser.lastWithdraw);
    //print(DateTime.now().difference(widget.modelUser.lastWithdraw!).inDays);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Withdraw Request"),
      ),

      body: widget.modelUser.lastWithdraw==null||DateTime.now().difference(widget.modelUser.lastWithdraw!).inDays>30?Column(
        children: [
          Text("Your current balance: ${widget.modelUser.balance}"),
          TextField(

            controller: number,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(

              hintText: "Bkash Number",
              border: OutlineInputBorder(

              )
            ),

          ),

          TextField(
            onChanged: (v){
            double k = double.parse(v);
            if(k<=widget.modelUser.balance){
              this.setState(() {
                canWithdraw = true;
              });
            }else{
              this.setState(() {
                canWithdraw = false;
              });

            }
          },
            controller: amount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(

                hintText: "Amount you want to withdraw",
                border: OutlineInputBorder(

                )
            ),


          ),

          Visibility(
            visible: canWithdraw,
            child: TextButton(
                onPressed: (){
                  this.setState(() {
                    processing=true;
                  });
                  fireBase.withdrawRequest(WithdrawModel(uid: widget.modelUser.uid, amount: double.parse(amount.text.trim()), number: number.text.trim())).then((value) {
                    this.setState(() {
                      result = value;
                    });
                  });
                  fireBase.addLastWithdraw();
                  fireBase.myProfile().then((value){
                    this.setState(() {
                      widget.modelUser = value;
                    });
                  });

            }, child: Text("Withdraw")),
          ),

          Visibility(
            visible: processing,
            child: result?Text("Your request is received, wait for the approval"):Text("Processing request"),
          )


        ],
      ):Center(child: Text("Cant withdraw now"),),
    );
  }
}
