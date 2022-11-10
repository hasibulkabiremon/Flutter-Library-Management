import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import '../db/db_helper.dart';
import '../model/book_model.dart';

class BookProvider extends ChangeNotifier {
  late BookModel bookItem;
  List<BookModel> bookList = [];

  Future<int> insertBook(BookModel bookModel) =>
      DataBase.insertBook(bookModel);

  Future<int> UpdateHire(int id)=>
      DataBase.UpdateHire(id);

  Future<int> UpdateReturn(int id)=>
      DataBase.UpdateReturn(id);

  BookModel getBookFromList(int id) =>
      bookList.firstWhere((element) => element.id==id);

  void getAllBooks() async{
    bookList = await DataBase.getAllBooks();
    notifyListeners();
  }
  void getIdBooks(int id) async{
    bookItem = await DataBase.getIdBooks(id);
    notifyListeners();
  }

  Future<BookModel> getBookbyId(int bookId) =>
      DataBase.getBookbyId(bookId);
}

