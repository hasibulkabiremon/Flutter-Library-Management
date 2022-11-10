import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lbrdemo/model/book_model.dart';
import 'package:lbrdemo/model/hire_model.dart';
import 'package:lbrdemo/providers/book_provider.dart';
import 'package:lbrdemo/providers/hire_provider.dart';
import 'package:lbrdemo/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  static const String routeName = '/book_details';

  const BookDetails({Key? key}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  DateTime? date;
  String? returndate;
  String? issuedate;
  int? id;
  late String name;
  late BookProvider provider;
  late UserProvider userProvider;
  late HireProvider hireProvider;

  @override
  void didChangeDependencies() {
    provider = Provider.of<BookProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    hireProvider = Provider.of<HireProvider>(context,listen: false);
    final argList = ModalRoute
        .of(context)!
        .settings
        .arguments as List;
    id = argList[0];
    name = argList[1];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
        ],
      ),
      body: Center(
        child: FutureBuilder<BookModel>(
            future: provider.getBookbyId(id!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final book = snapshot.data!;
                return ListView(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      child: Image.file(
                        File(book.bookImage), height: 300,
                        width: 150,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Table(
                      columnWidths: {
                        0: FlexColumnWidth(3.5),
                        1: FlexColumnWidth(.5),
                        2: FlexColumnWidth(6),
                      },
                      children: [
                        TableRow(children: [
                          // Text('Id'),
                          Text('Book Name',style: TextStyle(fontSize: 18)),
                          Text(':',style: TextStyle(fontSize: 18)),
                          Text('${book.bookName}',style: TextStyle(fontSize: 18)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          Text('Author Name',style: TextStyle(fontSize: 18)),
                          Text(':',style: TextStyle(fontSize: 18)),
                          Text('${book.bookAuthor}',style: TextStyle(fontSize: 18)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          const Text('Book Catagory',style: TextStyle(fontSize: 18)),
                          const Text(':',style: TextStyle(fontSize: 18)),
                          Text(book.categories,style: TextStyle(fontSize: 18)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          Text('Book Language',style: TextStyle(fontSize: 18)),
                          Text(':',style: TextStyle(fontSize: 18)),
                          Text('${book.language}',style: TextStyle(fontSize: 18)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          Text('Book Publisher',style: TextStyle(fontSize: 18)),
                          Text(':',style: TextStyle(fontSize: 18)),
                          Text('${book.publication}',style: TextStyle(fontSize: 18)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                          Text('',style: TextStyle(fontSize: 8)),
                        ]),
                        TableRow(children: [
                          // Text('Id'),
                          Text('Published Date',style: TextStyle(fontSize: 18)),
                          Text(':',style: TextStyle(fontSize: 18)),
                          Text('${book.publishedDate}',style: TextStyle(fontSize: 18)),
                        ]),

                      ],
                    ),
                    SizedBox(height: 20,),
                    if (!book.bookHired)
                      Center(
                        child:
                        ElevatedButton(
                          onPressed: () {
                            getHire();
                          },
                          child: Text('Borrow'),
                        ),
                      ),
                    if (book.bookHired)
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                            }, child: Text('Not Available')),
                      ),
                  ],
                );
              }
              if (snapshot.hasError) {
                return const Text('data');
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }

  void getHire() {
    date = DateTime.now();
    issuedate = date.toString().substring(0,10);
    final hirebook = HireModel(
      userId: userProvider.userModel!.userId!,
      bookId: id!,
      issueDate: issuedate!,
      returnDate: issuedate!,
    );
    provider.UpdateHire(id!);
    hireProvider.insertHireRecord(hirebook).then((value) {
      provider.getAllBooks();
      Navigator.pop(context);
    }).catchError((error){
      print(error.toString());
    });

  }

  void giveReturn() {
    provider.UpdateReturn(id!);
    hireProvider.UpdateHireHistoryC(userProvider.userModel!.userId!,id!);
  }
}
