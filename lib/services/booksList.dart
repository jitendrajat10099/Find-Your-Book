import 'package:cloud_firestore/cloud_firestore.dart';

class BooksList{
  
  getBooksList(String subject , String department , String semester){
    return Firestore.instance.collection('books')
    .where('subject' ,isEqualTo: subject )
    .where('department' , isEqualTo: department)
    .where('semester' , isEqualTo: semester)
    .getDocuments();
    //.snapshots();
  }


}