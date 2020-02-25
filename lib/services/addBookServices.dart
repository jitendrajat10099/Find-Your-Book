import 'package:cloud_firestore/cloud_firestore.dart';

class AddBooksServices{
    final uid;
    AddBooksServices({this.uid});
    final CollectionReference books = Firestore.instance.collection('books');

  Future updateUserData(String author , String department, String semester ,String subject ,String title) async{

    return await books.document(uid).setData({
      'author' : author,
      'department' : department,
      'semester' : semester,
      'subject' : subject,
      'title' : title,
    });
  }

}