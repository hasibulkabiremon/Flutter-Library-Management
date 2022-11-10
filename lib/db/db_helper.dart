import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import '../model/book_model.dart';
import '../model/hire_model.dart';
import '../model/user_model.dart';

class DataBase {
  static const String createTableBook = '''create table $tblBook(
  $tblBookId integer primary key autoincrement,
  $tblBookName text,
  $tblBookAuthor text,
  $tblBookCategories text,
  $tblBookPublications text,
  $tblBookPublishedDate text,
  $tblBookLanguage text,
  $tblBookImage text,
  $tblBookHired integer)''';

  static const String createTableUser = '''create table $tblUser(
  $tblUserId integer primary key autoincrement,
  $tblUserEmail text,
  $tblUserPassword text,
  $tblUserAdmin integer)''';

  static const String createTableHire = '''create table $tblHire(
  $tblHireId integer primary key autoincrement,
  $tblHireUserId integer,
  $tblHireBookId integer,
  $tblHireIssueDate text,
  $tblHireReturnDate text,
  $tblHireFine integer)''';

  static Future<Database> open() async {

    final rootPath = await getDatabasesPath();
    final dataBasePath = path.join(rootPath, 'library_database');
    return openDatabase(dataBasePath, version: 1, onCreate: (db, version) async {
      await db.execute(createTableBook);
      await db.execute(createTableUser);
      await db.execute(createTableHire);
    });
  }

  static Future<int> insertBook(BookModel bookModel) async {
    final db = await open();
    return db.insert(tblBook, bookModel.toMap());
  }

  static Future<int> insertHireRecord(HireModel hireModel) async {
    final db = await open();
    return db.insert(tblHire, hireModel.toMap());
  }

  static getAllBooks() async {
    final db = await open();
    final mapList = await db.query(tblBook);
    return List.generate(mapList.length, (index) => BookModel.fromMap(mapList[index]));
  }

  static getIdBooks(int id) async {
    final db = await open();
    final mapList = await db.query(tblBook, where: '$tblBookId = ?', whereArgs: [id]);
    return BookModel.fromMap(mapList.first);
  }

  static getAllHireHistory() async {
    final db = await open();
    final mapList = await db.query(tblHire);
    return List.generate(mapList.length, (index) => HireModel.fromMap(mapList[index]));
  }

  static getAllHireHistoryById(int id) async {
    final db = await open();
    final mapList = await db.query(tblHire, where: '$tblHireUserId = ?',whereArgs: [id]);
    return List.generate(mapList.length, (index) => HireModel.fromMap(mapList[index]));
  }

  static Future<BookModel> getBookbyId(int id) async {
    final db = await open();
    final mapList = await db.query(tblBook, where: '$tblBookId = ?', whereArgs: [id]);
    return BookModel.fromMap(mapList.first);
  }

  static Future<int> insertUser(UserModel userModel) async {
    final db = await open();
    return db.insert(tblUser, userModel.toMap());
  }
  static Future<UserModel?> getUserByEmail(String email) async {
    final db = await open();
    final mapList = await db.query(tblUser,
      where: '$tblUserEmail = ?', whereArgs: [email],);
    if(mapList.isEmpty) return null;
    return UserModel.fromMap(mapList.first);
  }
  static Future<UserModel> getUserById(int id) async {
    final db = await open();
    final mapList = await db.query(tblUser,
      where: '$tblUserId = ?', whereArgs: [id],);
    return UserModel.fromMap(mapList.first);
  }

  static Future<int> UpdateHire(int id) async {
    final db = await open();
    return db.rawUpdate('UPDATE $tblBook SET $tblBookHired = 1 WHERE $tblBookId=$id');
  }

  static Future<int> UpdateReturn(int id) async {
    final db = await open();
    return db.rawUpdate('UPDATE $tblBook SET  $tblBookHired= 0 WHERE $tblBookId=$id');
  }

  static Future<int> UpdateHireHistory(int id) async {
    final db = await open();
    return db.rawUpdate('UPDATE $tblHire SET $tblHireFine = 2 WHERE $tblHireId=$id');
  }

  static Future<int> UpdateHireHistoryReturnDate(int id, String date) async {
    final db = await open();
    return db.rawUpdate("UPDATE $tblHire SET $tblHireReturnDate = '$date' WHERE $tblHireId = $id");
  }

  static Future<int> UpdateHireHistoryB(int id) async {
    final db = await open();
    return db.rawUpdate('UPDATE $tblHire SET $tblHireFine = 2 WHERE $tblHireId=$id');
  }

  static Future<int> UpdateHireHistoryC(int user_id, int id) async {
    final db = await open();
    return db.rawUpdate('UPDATE $tblHire SET $tblHireFine = 2 WHERE $tblHireUserId=$user_id AND $tblHireBookId=$id');
  }

}