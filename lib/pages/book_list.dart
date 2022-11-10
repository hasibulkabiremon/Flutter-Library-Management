import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lbrdemo/model/book_model.dart';
import 'package:lbrdemo/model/user_model.dart';
import 'package:lbrdemo/pages/book_details.dart';
import 'package:lbrdemo/pages/hire_history.dart';
import 'package:lbrdemo/pages/launcher_page.dart';
import 'package:lbrdemo/pages/return_book.dart';
import 'package:lbrdemo/pages/search_book.dart';
import 'package:lbrdemo/providers/book_provider.dart';
import 'package:lbrdemo/providers/user_provider.dart';
import 'package:lbrdemo/utils/helper_functions.dart';
import 'package:provider/provider.dart';

import '../page_helper/booklist_helper.dart';
import 'add_new_book.dart';

class BookList extends StatefulWidget {
  static const String routeName = '/';

  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  late BookProvider provider;
  late UserProvider userProvider;
  @override
  void didChangeDependencies() {
    provider = Provider.of<BookProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    provider.getAllBooks();
    super.didChangeDependencies();
  }
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library Book List'), actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SearchList.routeName);
          },
          icon: const Icon(Icons.search),
        ),
        if(!userProvider.userModel.admin)IconButton(
          onPressed: () {
            Navigator.pushNamed(context, BookHiredUser.routeName);
          },
          icon: const Icon(Icons.assignment_return),
        ),
        if(userProvider.userModel.admin)IconButton(
          onPressed: () {
            Navigator.pushNamed(context, BookHired.routeName);
          },
          icon: const Icon(Icons.history),
        ),
        IconButton(
          onPressed: () async {
            await setLoginStatus(false);
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          },
          icon: const Icon(Icons.logout),
        ),
      ]),
      floatingActionButton: userProvider.userModel.admin? FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewBook.routeName);
        },
        child: const Icon(Icons.add),
      ): null,
      body: Consumer<BookProvider>(
        builder: (context, provider, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 0.65,
          ),
          itemCount: provider.bookList.length,
          itemBuilder: (context, index) {
            final book = provider.bookList[index];
            return BookItem(book: book);
          },
        ),
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  final BookModel book;

  const BookItem({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, BookDetails.routeName,
          arguments: [book.id, book.bookName]),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Image.file(
                File(book.bookImage),
                width: double.infinity,
                height: 180,
                fit: BoxFit.fitWidth,
              ),
              ListTile(
                title: Text(book.bookName),
                subtitle: Text(book.bookAuthor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
