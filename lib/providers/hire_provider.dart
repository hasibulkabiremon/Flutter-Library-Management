import 'package:flutter/widgets.dart';
import 'package:lbrdemo/db/db_helper.dart';
import 'package:lbrdemo/model/hire_model.dart';


class HireProvider extends ChangeNotifier{
  List<HireModel> hireHistory = [];

  Future<int> insertHireRecord(HireModel hireModel)=>
    DataBase.insertHireRecord(hireModel);

  void getAllHireHistory() async {
    hireHistory = await DataBase.getAllHireHistory();
    notifyListeners();
  }

  void getAllHireHistoryById(int id) async {
    hireHistory = await DataBase.getAllHireHistoryById(id);
    notifyListeners();
  }


  Future<int> UpdateHireHistory(int id)=>
      DataBase.UpdateHireHistory(id);

  Future<int> UpdateHireHistoryReturnDate(int id, String date)=>
      DataBase.UpdateHireHistoryReturnDate(id, date);

  Future<int> UpdateHireHistoryB(int id)=>
      DataBase.UpdateHireHistoryB(id);

  Future<int> UpdateHireHistoryC(int user_id, int id)=>
      DataBase.UpdateHireHistoryC(user_id,id);


}