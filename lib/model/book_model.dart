const String tblBook = 'tbl_book';
const String tblBookId = 'id';
const String tblBookName = 'book_name';
const String tblBookAuthor = 'book_author';
const String tblBookCategories = 'categories';
const String tblBookPublications = 'publication';
const String tblBookPublishedDate = 'publish_date';
const String tblBookLanguage = 'language';
const String tblBookImage = 'book_image';
const String tblBookHired = 'book_hired';

class BookModel {
  int? id;
  String bookName;
  String bookAuthor;
  String categories;
  String publication;
  String publishedDate;
  String language;
  String bookImage;
  bool bookHired;

  BookModel({
    this.id,
    required this.bookName,
    required this.bookAuthor,
    required this.categories,
    required this.publication,
    required this.publishedDate,
    required this.language,
    required this.bookImage,
    this.bookHired = false,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblBookId: id,
      tblBookName: bookName,
      tblBookAuthor: bookAuthor,
      tblBookCategories: categories,
      tblBookPublications: publication,
      tblBookPublishedDate: publishedDate,
      tblBookLanguage: language,
      tblBookImage: bookImage,
      tblBookHired: bookHired ? 1 : 0,
    };
    return map;
  }

  factory BookModel.fromMap(Map<String, dynamic> map) => BookModel(
        id: map[tblBookId],
        bookName: map[tblBookName],
        bookAuthor: map[tblBookAuthor],
        categories: map[tblBookCategories],
        publication: map[tblBookPublications],
        publishedDate: map[tblBookPublishedDate],
        language: map[tblBookLanguage],
        bookImage: map[tblBookImage],
        bookHired: map[tblBookHired] == null
            ? false
            : map[tblBookHired] == 0
                ? false
                : true,
      );
}
