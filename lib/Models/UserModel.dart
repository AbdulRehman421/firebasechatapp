class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilpic;
  String? status;

  UserModel({this.uid, this.fullname, this.email, this.status, this.profilpic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["name"];
    email = map["email"];
      profilpic = map["profileImageUrl"];
    status = map["status"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": fullname,
      "email": email,
      "profileImageUrl" : profilpic,
      "status" : status
    };
  }
}