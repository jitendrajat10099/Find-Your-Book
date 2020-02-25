import 'package:auth/screens/auth/forgot.dart';
import 'package:auth/screens/home/home.dart';
import 'package:auth/screens/auth/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email , _password;
  bool _loading = false;
  FocusNode _myFocusNode;
 final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _myFocusNode = FocusNode();
  }
  @override
  void dispose() {
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? _circularProgressIndicator() : Scaffold(
      appBar: AppBar(
        title: Text('Login In'),
        // elevation: 0.0,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 15.0),
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

                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        onTap: (){
                            Navigator.push(context , MaterialPageRoute(builder: (context)=> ForgotPassword()));
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.teal,
                            // fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                            ),
                        ),
                      ),
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
                          onTap: login,
                          child: Center(
                            child: Text(
                              'LOGIN',
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
                          'New to Book Sharing ?',
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            
                            Navigator.push(context , MaterialPageRoute(builder: (context)=> SignUp() , fullscreenDialog: true));
                          },
                          child: Text(
                            'Register',
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
    );
  }

  Future<void> login() async{
    final _formState = _formkey.currentState;
    if(_formState.validate()){
        setState(() {
          _loading = true;
        });
        _formState.save();
        try{
          AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
          final FirebaseUser user = result.user;
          //kyunki jitu ne bola tha
          Navigator.pushReplacement(context , MaterialPageRoute(builder: (context)=> Home(user : user)));
        }
        catch(e){
          print(e.message);
          setState(() {
            _loading = false;
          });
          _showDialog();
        }
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.fromLTRB(5 ,50 , 5 , 10),
            child: AlertDialog(
            elevation: 24.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))
            ),
            backgroundColor: Colors.teal,
            title: null,
            content: Text('Invalid Username or Password' , 
                      style: TextStyle(
                      color : Colors.white,
                      ),
                    ),
                    
            actions: <Widget>[
               FlatButton(
                child: Text("Close",
                style: TextStyle(
                  color : Colors.white,
                ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _circularProgressIndicator(){
    return Container(
      width : MediaQuery.of(context).size.width,
      height : MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child : CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.teal),
              strokeWidth: 3.0,
          )
        ),
      ),
    );
  }

  
}