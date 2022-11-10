import 'package:flutter/material.dart';
import 'package:lbrdemo/model/hire_model.dart';
import 'package:lbrdemo/model/user_model.dart';
import 'package:lbrdemo/providers/book_provider.dart';
import 'package:lbrdemo/providers/hire_provider.dart';
import 'package:lbrdemo/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BookHiredUser extends StatefulWidget {
  static const String routeName = '/hire_history_user';

  const BookHiredUser({Key? key}) : super(key: key);

  @override
  State<BookHiredUser> createState() => _BookHiredUserState();
}

class _BookHiredUserState extends State<BookHiredUser> {
  late HireProvider hireProvider;
  late UserProvider userProvider;
  late UserModel userModel;
  int? id;


  @override
  void didChangeDependencies() {
    hireProvider = Provider.of<HireProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userModel = Provider.of<UserProvider>(context, listen: false).userModel!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    id = userProvider.userModel?.userId!;
    hireProvider.getAllHireHistoryById(id!);
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Hired History'),
      ),
      body: Column(
        children: [
          Table(
            children: [
              TableRow(children: [
                // Text('Id'),
                Text('User_ID'),
                Text('Book_ID'),
                Text('Issued'),
                Text('Status/Returned'),
              ]),
            ],
          ),
          Expanded(
            child: Consumer<HireProvider>(
              builder: (context, provider, child) => ListView.builder(
                itemCount: provider.hireHistory.length,
                itemBuilder: (context, index) {
                  final history = provider.hireHistory[index];
                  return HireHistory(
                    history: history,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HireHistory extends StatefulWidget {
  final HireModel history;

  const HireHistory({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  State<HireHistory> createState() => _HireHistoryState();
}

class _HireHistoryState extends State<HireHistory> {
  late HireProvider hireProvider;
  late BookProvider bookProvider;

  @override
  void didChangeDependencies() {
    hireProvider = Provider.of<HireProvider>(context, listen: false);
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Padding(padding: const EdgeInsets.all(6),
        //   child: Text('${widget.history.hireId}'),
        // ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text('${widget.history.userId}'),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text('${widget.history.bookId}'),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text('${widget.history.issueDate}'),
        ),
        if ((widget.history.fine) == 1)
          ElevatedButton(
            onPressed: () {
              getHireB();
              Navigator.pushReplacementNamed(context, BookHiredUser.routeName);
            },
            child: Text('Return'),
          ),
        if ((widget.history.fine)! > 1)
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text('${widget.history.returnDate}'),
          )
      ],
    );
  }

  getHire() {
    hireProvider.UpdateHireHistory(widget.history.hireId!);
    bookProvider.UpdateHire(widget.history.bookId!);
  }

  getHireB() {
    DateTime? date;
    String? returndate;
    date = DateTime.now();
    returndate = date.toString().substring(0,10);

    hireProvider.UpdateHireHistoryB(widget.history.hireId!);
    hireProvider.UpdateHireHistoryReturnDate(widget.history.hireId!, returndate);
    bookProvider.UpdateReturn(widget.history.bookId!);
  }
}
