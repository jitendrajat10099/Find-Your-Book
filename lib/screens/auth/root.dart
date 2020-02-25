import 'package:auth/screens/auth/signIn.dart';
import 'package:auth/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  bool isLogin = false;
  FirebaseUser _user;
  @override
  void initState() {
    super.initState();
    currentUser().then((user) =>{
      setState(
        (){
          isLogin = user.uid==null  ? false : true;
          _user = user;
        }
      )
    } );
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ? Home(user: _user) : SignIn();
  }
  Future< FirebaseUser > currentUser() async{
    FirebaseUser user =  await FirebaseAuth.instance.currentUser();
    return user;
  }

}