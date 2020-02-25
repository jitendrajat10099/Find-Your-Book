import 'package:auth/services/addBookServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}


class _AddBookState extends State<AddBook> {
  String _email , _password , _semester, _subject ,_department,_bookTitle,_author ;
  List<String> _lessons = ["Computer Engineering",
    "Mechanical Engineering",
    "Electrical Engineering",
    "Electronics Engineering",
    "Chemical Engineering",
    "Civil Engineering",
  ];
  List<String> _sem = ["1st Semester",
    "2nd Semester",
    "3rd Semester",
    "4th Semester",
    "5th Semester",
    "6th Semester",
    "7th Semester",
    "8th Semester",
  ];
  List<DropdownMenuItem<String>> _dropdownMenuItems1;
  List<DropdownMenuItem<String>> _dropdownMenuItems2;
  String _selectedLesson;
  String _selectedSem;
  List<DropdownMenuItem<String>> buildDropdownMenuItems(List _lesson){
                            List<DropdownMenuItem<String>> items=List();
                            for(String lessoni in _lesson){
                              items.add(DropdownMenuItem(
                                value: lessoni,
                                child: Text(lessoni),
                              )
                              );
                            }
                            return items;
                          }

  

  FocusNode myFocusNode;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  onChangeDropdownItem1(String selectedlesson){
    setState(() {
      _selectedLesson=selectedlesson;
    });
  }
  onChangeDropdownItem2(String selectedlesson){
    setState(() {
      _selectedSem=selectedlesson;
    });
  }

  @override
  void initState() {
    _dropdownMenuItems1=buildDropdownMenuItems(_lessons);
    _dropdownMenuItems2=buildDropdownMenuItems(_sem);
    _selectedLesson = _dropdownMenuItems1[0].value;
    _selectedSem = _dropdownMenuItems2[0].value;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                
                  children: <Widget>[
                      Text('Department',style: TextStyle(fontSize: 18),),
                      SizedBox(height: 5.0),
                      DropdownButton(
                              iconSize: 30,
                              value: _selectedLesson,
                              items: _dropdownMenuItems1,
                              onChanged: onChangeDropdownItem1,
                            ),
                      SizedBox(height: 10),

                      Text('Semester',style: TextStyle(fontSize: 18),),
                      SizedBox(height: 10),
                      DropdownButton(
                              iconSize: 30,
                              value: _selectedSem,
                              items: _dropdownMenuItems2,
                              onChanged: onChangeDropdownItem2,
                            ),
                      SizedBox(height: 10),


                      TextFormField(
                        validator:(input){
                          if(input.isEmpty){
                            return 'Please Enter Subject';
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
                        onSaved: (input)=> _subject = input,
                        decoration: InputDecoration(
                          labelText: 'Subject',
                        ),
                      ),
                      SizedBox(height: 10),


                      TextFormField(
                        validator:(input){
                          if(input.isEmpty){
                            return 'Please Enter Book Title';
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
                        onSaved: (input)=> _bookTitle = input,
                        decoration: InputDecoration(
                          labelText: 'Book Title',
                        ),
                      ),
                      SizedBox(height: 10),


                      TextFormField(
                        validator:(input){
                          if(input.isEmpty){
                            return 'Please Enter Author Name';
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
                        onSaved: (input)=> _author = input,
                        decoration: InputDecoration(
                          labelText: 'Author Name',
                        ),
                      ),
                      SizedBox(height: 10),
                      
                      
                      
                      
                      
                      
                      SizedBox(height: 40.0),
                      Center(
                        child: Container(
                          height: 45.0,
                          width: 150,
                          child: Material(
                            borderRadius: BorderRadius.circular(22.0),
                            shadowColor: Colors.tealAccent,
                            color: Colors.teal,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: input,
                              child: Center(
                                child: Text(
                                  'ADD BOOK',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                  ],
                )
          ),
        ),
      ),
    );
  }
  Future<void> input() async{
    final _formState = _formkey.currentState;
    if(_formState.validate()){
        _formState.save();
        try{
          final FirebaseUser user =await FirebaseAuth.instance.currentUser();
          final uid = user.uid;

          await AddBooksServices(uid: uid).updateUserData(_author, _selectedLesson, _selectedSem, _subject, _bookTitle);
          Navigator.of(context).pop();
        }
        catch(e){
          print(e.message);
        }
   }
  
  }
}