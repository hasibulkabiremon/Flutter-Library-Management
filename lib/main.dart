import 'package:flutter/material.dart';
import 'package:lbrdemo/pages/add_new_book.dart';
import 'package:lbrdemo/pages/book_details.dart';
import 'package:lbrdemo/pages/book_list.dart';
import 'package:lbrdemo/pages/hire_history.dart';
import 'package:lbrdemo/pages/launcher_page.dart';
import 'package:lbrdemo/pages/login_page.dart';
import 'package:lbrdemo/pages/return_book.dart';
import 'package:lbrdemo/pages/search_book.dart';
import 'package:lbrdemo/providers/book_provider.dart';
import 'package:lbrdemo/providers/hire_provider.dart';
import 'package:lbrdemo/providers/user_provider.dart';
import 'package:lbrdemo/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BookProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => HireProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color(0xFFFEEAE6)
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        BookList.routeName: (context) => const BookList(),
        AddNewBook.routeName: (context) => const AddNewBook(),
        BookHiredUser.routeName: (context) => const BookHiredUser(),
        BookDetails.routeName:(context) => const BookDetails(),
        BookHired.routeName:(context) => const BookHired(),
        LoginPage.routeName:(context) => const LoginPage(),
        SearchList.routeName:(context) => const SearchList(),
      },
    );
  }
}
