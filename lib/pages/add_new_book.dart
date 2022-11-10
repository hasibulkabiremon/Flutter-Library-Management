import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lbrdemo/utils/helper_functions.dart';
import 'package:provider/provider.dart';

import '../model/book_model.dart';
import '../providers/book_provider.dart';

class AddNewBook extends StatefulWidget {
  static const String routeName = '/add_book';

  const AddNewBook({Key? key}) : super(key: key);

  @override
  State<AddNewBook> createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBook> {
  late BookProvider bookProvider;
  final _fromKey = GlobalKey<FormState>();
  final bookNameController = TextEditingController();
  final bookAuthorController = TextEditingController();
  String? selectedCategory;
  final bookPublicationController = TextEditingController();
  DateTime? publicationDate;
  final bookLanguageNameController = TextEditingController();
  String? imagePath;
  int? id;

  @override
  void didChangeDependencies() {
    bookProvider = Provider.of(context, listen: false);
    id = ModalRoute.of(context)!.settings.arguments as int?;
    if (id != null) {
      _setData();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bookNameController.dispose();
    bookAuthorController.dispose();
    bookPublicationController.dispose();
    bookLanguageNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New BooK'),
          actions: [
            IconButton(
              onPressed: () {
                saveBook();
                bookProvider.getAllBooks();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Form(
          key: _fromKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: bookNameController,
                  decoration: InputDecoration(
                      hintText: 'Enter Book Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This fields must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: bookAuthorController,
                  decoration: InputDecoration(
                      hintText: 'Enter Author Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This fiels must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: bookPublicationController,
                  decoration: InputDecoration(
                      hintText: 'Enter Publication Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This fiels must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: bookLanguageNameController,
                  decoration: InputDecoration(
                      hintText: 'Enter Language',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          const BorderSide(color: Colors.blue, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This fiels must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue, width: 1)
                      )
                  ),
                  hint: Text('Select a book Type'),
                  items: bookTypes.map((e) => DropdownMenuItem(value: e ,child: Text(e!))).toList(),
                  value: selectedCategory,
                  validator: (value) {
                    if(value==null || value.isEmpty ){
                      return 'Please select a catagory';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: selectDate,
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Select Published Date'),
                    ),
                    Text(publicationDate == null ? 'No date chosen':
                    getFormattedDate(publicationDate!, 'dd/MM/yyy'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imagePath == null
                        ? const Icon(
                            Icons.book,
                            size: 100,
                          )
                        : Image.file(
                            File(imagePath!),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                    TextButton.icon(
                        onPressed: getImage,
                        icon: const Icon(Icons.photo),
                        label: const Text('Please select an Image'))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  // void _clearController() {
  //   bookNameController.clear();
  //   bookAuthorController.clear();
  //   bookCategoryController.clear();
  //   bookPublicationController.clear();
  //   bookCategoryController.clear();
  //   bookLanguageNameController.clear();
  // }

  void saveBook() {
    if (imagePath == null) {
      showMsg(context, 'Please select an Image');
      return;
    }

    if (_fromKey.currentState!.validate()) {
      final book = BookModel(
        bookName: bookNameController.text,
        bookAuthor: bookAuthorController.text,
        categories: selectedCategory!,
        publication: bookPublicationController.text,
        publishedDate: getFormattedDate(publicationDate!, datePattern),
        language: bookLanguageNameController.text,
        bookImage: imagePath!,
      );
      if (id != null) {
        book.id = id;
      } else {
        bookProvider.insertBook(book);
      }
    }
  }

  void _setData() {
    final book = bookProvider.getBookFromList(id!);
    bookNameController.text = book.bookName;
    bookAuthorController.text = book.bookAuthor;
    selectedCategory = book.categories;
  }

  void getImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        imagePath = file.path;
      });
    }
  }

  void selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        publicationDate = selectedDate;
      });
    }
  }
}
