import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  final String uid;
  Users({this.uid});
  final CollectionReference users = Firestore.instance.collection('users');
  
  Future updateUserData(String name , String mobNo, String email ,String admissionNo) async{

    return await users.document(admissionNo).setData({
      'name' : name,
      'mobNo' : mobNo,
      'email' : email,
    });
  }

}