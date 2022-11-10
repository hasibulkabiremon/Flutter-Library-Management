import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lbrdemo/model/book_model.dart';
import 'package:lbrdemo/model/hire_model.dart';
import 'package:lbrdemo/model/user_model.dart';
import 'package:lbrdemo/providers/book_provider.dart';
import 'package:lbrdemo/providers/hire_provider.dart';
import 'package:lbrdemo/providers/user_provider.dart';
import 'package:lbrdemo/utils/helper_functions.dart';
import 'package:provider/provider.dart';

class BookHired extends StatefulWidget {
  static const String routeName = '/hire_history';

  const BookHired({Key? key}) : super(key: key);

  @override
  State<BookHired> createState() => _BookHiredState();
}

class _BookHiredState extends State<BookHired> {
  late HireProvider hireProvider;

  @override
  void didChangeDependencies() {
    hireProvider = Provider.of<HireProvider>(context, listen: false);
    hireProvider.getAllHireHistory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
              Navigator.pushReplacementNamed(context, BookHired.routeName);
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
    final date = DateTime.now();
    final issueDate = date.toString().substring(0,10);
    final dt = widget.history.hireId;
    String datetime4 = DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(date);
    hireProvider.UpdateHireHistoryReturnDate(dt!,issueDate);
    hireProvider.UpdateHireHistoryB(widget.history.hireId!);
    bookProvider.UpdateReturn(widget.history.bookId!);
  }
}
