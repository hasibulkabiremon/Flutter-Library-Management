import 'package:flutter/material.dart';

class BookListHelper extends StatelessWidget {
  const BookListHelper({Key? key}) : super(key: key);

  List<Card> _bookListCard (int count) {
    List<Card> cards = List.generate(count, (int index) {
      return           Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset('images/book.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Book Name'),
                  SizedBox(height: 8,),
                  Text('Author'),
                ],
              ),
            )
          ],
        ),
      );

    });
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        childAspectRatio: 8.0 / 9.0,
        children:_bookListCard(30)
    );
  }
}
