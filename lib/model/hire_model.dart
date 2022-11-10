const String tblHire = 'tbl_hire';
const String tblHireId = 'hire_id';
const String tblHireUserId = 'user_id';
const String tblHireBookId = 'book_id';
const String tblHireIssueDate = 'issue_date';
const String tblHireReturnDate = 'return_date';
const String tblHireFine = 'fine';


class HireModel {
  int? hireId;
  int userId;
  int bookId;
  String issueDate;
  String returnDate;
  int? fine;

  HireModel({
    this.hireId,
    required this.userId,
    required this.bookId,
    required this.issueDate,
    required this.returnDate,
    this.fine=1,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblHireUserId: userId,
      tblHireBookId: bookId,
      tblHireIssueDate: issueDate,
      tblHireReturnDate: returnDate,
      tblHireFine: fine,
    };
    return map;
  }

  factory HireModel.fromMap(Map<String, dynamic> map) =>
      HireModel(
        hireId: map[tblHireId],
        userId: map[tblHireUserId],
        bookId: map[tblHireBookId],
        issueDate: map[tblHireIssueDate],
        returnDate: map[tblHireReturnDate],
        fine: map[tblHireFine]
      );
}
