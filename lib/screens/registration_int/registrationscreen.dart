import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icbapps/models/ModelUser.dart';

class Registration extends StatefulWidget {
  Registration({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: (){}, child: Text("Joining newmember")),
          TextButton(onPressed: (){
            Clipboard.setData(ClipboardData(text: widget.modelUser.refarralId)).then((value) {
              final snackbar = SnackBar(content: Text("Copied: ${widget.modelUser.refarralId}"));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            });
          }, child: Text("Refarral id")),
          TextButton(onPressed: (){}, child: Text("Team Member")),
        ],
      ),
    );
  }
}
