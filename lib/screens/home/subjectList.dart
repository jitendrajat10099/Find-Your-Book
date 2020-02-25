import 'package:auth/screens/home/bookManager.dart';
import 'package:auth/services/addBook.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Subject extends StatefulWidget {
   const Subject({ Key key , @required this.semester , @required this.department}) : super(key: key);
    final department;
    final semester;
  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  final databaseReference = Firestore.instance;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
               
              },
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(context , MaterialPageRoute(builder: (context)=> AddBook() , fullscreenDialog: true));
              },
            )
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text('Subjects'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body : StreamBuilder(
        
        stream : Firestore.instance.collection('department').snapshots(),
        builder: (context , snapshot){
            if(!snapshot.hasData) return Text('Loading ...');
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.documents[_getIndex(widget.department)][widget.semester].length,
              itemBuilder: (context , index){
                return Card(
                    elevation: 8.0,
                    // margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(0,128,128, .9)),
                      child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        title : Text(
                          snapshot.data.documents[_getIndex(widget.department)][widget.semester][index],
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                           trailing:
                            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>BookManager(department: widget.department, semester: widget.semester, subject: snapshot.data.documents[_getIndex(widget.department)][widget.semester][index])));
                            },
                  ),
                    ),
                );
              }
            );
        },
      ),
      bottomNavigationBar: makeBottom,
      );
  }
  
  void getData() {
    databaseReference
    .collection("department")
    .getDocuments()
    .then((QuerySnapshot snapshot) {
          snapshot.documents.forEach((f) => {
          print(f.data[widget.department][widget.semester]['subject']),
        },
      );
    }
  );
  }
  int _getIndex(String dept){
    if(dept=='Chemical Engineering')
      return 0;
    if(dept=='Civil Engineering')
      return 1;
    if(dept=='Computer Engineering')
      return 2;
    if(dept=='Electrical Engineering')
      return 3;
    if(dept=='Electronics Engineering')
      return 4;
    if(dept=='Mechanical Engineering')
      return 5;
  }
}
