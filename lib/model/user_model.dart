const String tblUser = ' tbl_user';
const String tblUserId = 'user_id';
const String tblUserEmail = 'user_email';
const String tblUserPassword = 'user_password';
const String tblUserAdmin = 'admin';

class UserModel {
  int? userId;
  String userEmail;
  String userPassword;
  bool admin;

  UserModel({
    this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.admin,
  });

  Map<String, dynamic> toMap() {
    final map = <String,dynamic>{
      tblUserEmail : userEmail,
      tblUserPassword : userPassword,
      tblUserAdmin : admin == null ?0 : admin == true ? 1 : 0,
    };
    if(userId != null) {
      map[tblUserId] = userId;
    }
    return map;
  }

  factory UserModel.fromMap
      (Map<String,dynamic> map) =>
      UserModel(
        userId: map[tblUserId],
        userEmail: map[tblUserEmail],
        userPassword: map[tblUserPassword],
        admin: map[tblUserAdmin] == 0 ? false : true,
      );
}
