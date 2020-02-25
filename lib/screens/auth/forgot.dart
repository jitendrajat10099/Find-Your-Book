import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}
class _ForgotPasswordState extends State<ForgotPassword> {
  String _email ;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FocusNode _myFocusNode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _scaffoldKey,
      body : SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical : 10.0 , horizontal: 25.0),
            child: Form(
                key  : _formkey,
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        TextFormField(
                          focusNode: _myFocusNode,
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
                        SizedBox(height: 40.0),
                        Container(
                        height: 45.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(22.0),
                          shadowColor: Colors.tealAccent,
                          color: Colors.teal,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: _sendForgotPassWordLink,
                            child: Center(
                              child: Text(
                                'SEND EMAIL',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                        Container(
                          height: 43.0,
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 1.0
                                    ),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Center(
                                    child: Text('Go Back',
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                              )
                            )
                          )  
                        ),
                    ],
                  )
              )
          ),
      ),
    );
  }
  void _sendForgotPassWordLink() {
  final _formState = _formkey.currentState;
  if (_formState.validate()) {
    _formState.save();
  FirebaseAuth.instance.sendPasswordResetEmail(email: _email).
    then((result){
         _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: Center(child: Text('Requesting password reset email' , textAlign : TextAlign.center),
          ) , 
        ),
      );
    }
  ).catchError((error){
        _scaffoldKey.currentState..showSnackBar(
        const SnackBar(content: const Text('Password reset failed, did you enter the correct address?')
        ),
      );
    });
  }}
}