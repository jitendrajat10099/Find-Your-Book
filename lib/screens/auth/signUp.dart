import 'package:auth/screens/home/home.dart';
import 'package:auth/screens/auth/signIn.dart';
import 'package:auth/services/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email , _password , _admissionNo, _mobNo ,_name ;
  FocusNode myFocusNode;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        // elevation: 0.0,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 15.0),
              child: Form(
              key  : _formkey,
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      SizedBox(height: 5.0),
                      TextFormField(
                        validator:(input){
                          if(input.isEmpty){
                            return 'Please Enter Name';
                          }
                          else{
                            return null;
                          }
                        },
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onSaved: (input)=> _name = input,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator:(input){
                          if(input.isEmpty){
                            return 'Please Enter Addmission Number';
                          }
                          else{
                            return null;
                          }
                        },
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onSaved: (input)=> _admissionNo = input,
                        decoration: InputDecoration(
                          labelText: 'Admission Number',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator:(input){
                          if(input.isEmpty){
                            return 'Please Enter Mobile Number';
                          }
                          else{
                            Pattern mobile = r'(^[0-9]{10}$)';
                            RegExp regExp = RegExp(mobile);
                            if(!regExp.hasMatch(input)){
                              return 'Enter valid Mobile Number';
                            }
                            return null;
                          }
                        },
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onSaved: (input)=> _mobNo = input,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        focusNode: myFocusNode,
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        validator:(input){
                          if(input.isEmpty){
                            return 'Please type a Email';
                          }
                          else{
                            Pattern pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern);
                            if(!regex.hasMatch(input))
                             return 'Enter valid Email';
                             else
                             return null;
                          }
                        },
                        onSaved: (input)=> _email = input,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          //   focusedBorder: UnderlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.green)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                       SizedBox(height: 5.0),
                      TextFormField(
                        validator:(input){
                          if(input.length < 6 ){
                            return 'Your password needs to be atleast 6 characters';
                          }
                          else{
                            return null;
                          }
                        },
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onSaved: (input)=> _password = input,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      
                      SizedBox(height: 20.0),
                      Container(
                        height: 45.0,
                        width: 150,
                        child: Material(
                          borderRadius: BorderRadius.circular(22.0),
                          shadowColor: Colors.tealAccent,
                          color: Colors.teal,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: signup,
                            child: Center(
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an Account ?',
                          ),
                          SizedBox(width: 7.0),
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).pushNamed('/signup');
                              // Navigator.push(context , MaterialPageRoute(builder: (context)=> SignIn()));
                                Navigator.of(context).pop();
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                                ),
                            ),
                          )
                        ],
                      )
                  ],
                )
          ),
        ),
      ),
    );
  }
    Future<void> signup() async{
    final _formState = _formkey.currentState;
    if(_formState.validate()){
        _formState.save();
        try{
          AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
          final FirebaseUser user = result.user;
          await Users(uid : _admissionNo).updateUserData(_name, _mobNo, _email , _admissionNo);
          user.sendEmailVerification();
          Navigator.of(context).pop();
          Navigator.pushReplacement(context , MaterialPageRoute(builder: (context)=> SignIn()));
        }
        catch(e){
          print(e.message);
        }
    }
  }
}