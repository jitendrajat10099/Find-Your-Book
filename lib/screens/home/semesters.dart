import 'package:auth/screens/home/subjectList.dart';
import 'package:auth/services/addBook.dart';
import 'package:flutter/material.dart';

class Semesters extends StatefulWidget {
  const Semesters({ Key key , @required this.department}) : super(key: key);
  final String department;
  @override
  _SemestersState createState() => _SemestersState();
}

class _SemestersState extends State<Semesters> {
  String semester;
//pass semester and department further
  List<String> lessons = ["1st Semester",
    "2nd Semester",
    "3rd Semester",
    "4th Semester",
    "5th Semester",
    "6th Semester",
    "7th Semester",
    "8th Semester",
  ];
  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(String lesson) => ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
          title: Text(
            lesson,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>Subject(semester: lesson , department : widget.department) ));
          },
        );

    Card makeCard(String lesson) => Card(
          elevation: 8.0,
          // margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(0,128,128, .9)),
            child: makeListTile(lesson),
          ),
        );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(lessons[index]);
        },
      ),
    );
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
    
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text('Semesters'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        SizedBox(width: 10),
      ],
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}

//bottomNavigationBar
