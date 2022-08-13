import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/ModelUser.dart';

class DailyWork extends StatefulWidget {
  DailyWork({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;


  @override
  State<DailyWork> createState() => _DailyWorkState();
}

class _DailyWorkState extends State<DailyWork> {

  FireBase fireBase = FireBase();
  RewardedAd? rewardedAd;
  bool loaded = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: TextButton(onPressed: (){
          
          if(loaded){
            rewardedAd?.show(onUserEarnedReward: (without, item)async{
              print("rewarded");
              final x = await fireBase.rewardUser(widget.modelUser);
              if(x==true){
                print("rewarded");
              }else{
                print("not rewarded");
              }
            });
          }else{
            RewardedAd.load(
                adUnitId: "ca-app-pub-3940256099942544/5224354917",
                request: AdRequest(),
                rewardedAdLoadCallback: RewardedAdLoadCallback(
                    onAdLoaded: (ad){
                      this.setState(() {
                        rewardedAd = ad;
                        loaded=true;
                      });
                    },
                    onAdFailedToLoad: (e){
                      print(e);
                    }
                )
            );
          }

          
          

        },child: Text(!loaded?"load add":"show Add"),),
      ),
    );
  }
}
