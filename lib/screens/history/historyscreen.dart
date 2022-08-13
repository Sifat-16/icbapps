import 'package:flutter/material.dart';
import 'package:icbapps/models/ModelUser.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.currency_exchange),
                Text("Cash Chart")
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)

                ),
                child: Column(
                  children: [
                    Text("Daily work"),
                    Text("Tk: ${widget.modelUser.workbonus}")
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)

                ),
                child: Column(
                  children: [
                    Text("Total Point"),
                    Text("Tk: ${widget.modelUser.balance}")
                  ],
                ),
              ),

            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)

                ),
                child: Column(
                  children: [
                    Text("Withdrawal point"),
                    Text("Tk: ${widget.modelUser.withdrawal}")
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)

                ),
                child: Column(
                  children: [
                    Text("Reference Point"),
                    Text("Tk: ${widget.modelUser.reference}")
                  ],
                ),
              ),

            ],

          )
        ],
      ),
    );
  }
}
