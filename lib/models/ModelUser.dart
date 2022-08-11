class ModelUser{
  String? username;
  String? uid;
  String? email;
  String? fullName;
  String? country;
  String? refarralId;
  String? profileImage;
  double? balance=0;

  ModelUser({this.username, this.uid, this.email, this.fullName, this.country, this.refarralId, this.profileImage, this.balance});

  Map<String, dynamic> toJson()=>{
    "username":username,
    "uid":uid,
    "email":email,
    "fullName":fullName,
    "country":country,
    "refarralId":refarralId,
    "profileImage":profileImage,
    "balance":balance
  };

}