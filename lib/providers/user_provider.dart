import 'package:flutter/material.dart';
import 'package:lbrdemo/db/db_helper.dart';

import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel userModel;

  Future<UserModel?> getUserByEmail(String email) =>
      DataBase.getUserByEmail(email);

  Future<int> insertUser(UserModel userModel) =>
      DataBase.insertUser(userModel);

  Future<void> getUserById(int id) async {
    userModel = await DataBase.getUserById(id);
  }

}