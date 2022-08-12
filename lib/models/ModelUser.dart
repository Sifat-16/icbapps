class ModelUser{
  String? username;
  String? uid;
  String? email;
  String? fullName;
  String? refarralId;
  String? profileImage;
  List<String> teamMember=[];
  double balance=0.0;

  ModelUser({this.username, this.uid, this.email, this.fullName, this.refarralId, this.profileImage});

  Map<String, dynamic> toJson(){

    return {
      "username":username,
      "uid":uid,
      "email":email,
      "fullName":fullName,
      "refarralId":refarralId,
      "profileImage":profileImage,
      "teamMember":teamMember,
      "balance":balance
    };
  }

  ModelUser.fromJson(Map<String, dynamic> json){
    try{
      username = json["username"];
    }catch(e){
        print("username");
    }
    try{
      uid = json["uid"];
    }catch(e){
        print("uid");
    }
    try{
      email = json["email"];
    }catch(e){
        print("email");
    }
    try{
      fullName = json["fullName"];
    }catch(e){
      print("fullname");

    }
    try{
      refarralId = json["refarralId"];
    }catch(e){
        print("refarralid");
    }
    try{
      profileImage = json["profileImage"];
    }catch(e){
        print("profileimage");
    }

    try{

      if(json["teamMember"]!=null){
        teamMember = [];
        json["teamMember"].forEach((e){
            teamMember.add(e);
        });
      }else{
        teamMember = [];
      }

    }catch(e){
      //print(json["teamMember"]);
        print("teamMemberrrrrr");
    }

    try{
      balance = json["balance"];
    }catch(e){
      print("balance");
    }




  }
}