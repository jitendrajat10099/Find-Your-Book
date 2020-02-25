import 'package:auth/screens/home/detaildBook.dart';
import 'package:auth/screens/home/home.dart';
import 'package:auth/services/addBook.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BookManager extends StatefulWidget {
   const BookManager({ Key key , @required this.semester , @required this.department , @required this.subject}) : super(key: key);
    final department;
    final semester;
    final subject;
  @override
  _BookManagerState createState() => _BookManagerState();
}

class _BookManagerState extends State<BookManager> {
  final databaseReference = Firestore.instance;


  @override
  void initState() {
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
               Navigator.of(context).pop();
               
              }
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
      title: Text('Books'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          SizedBox(width: 10),
        ],
      ),
      body : StreamBuilder(
        
        stream : Firestore.instance.collection('books')
        .where('subject' ,isEqualTo: widget.subject )
        .where('department' , isEqualTo: widget.department)
        .where('semester' , isEqualTo: widget.semester)
        .snapshots(),
        builder: (context , snapshot){
            if(!snapshot.hasData) return Text('Loading ...');
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
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
                          snapshot.data.documents[index]['title'].toUpperCase(),
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 18),
                          ),
                          subtitle: Text(snapshot.data.documents[index]['author'].toUpperCase(),
                          style: TextStyle(color: Colors.white , fontStyle: FontStyle.italic ),
                          )
                          ,
                           trailing:
                            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) =>DetailedBook(department: widget.department, semester: widget.semester, subject: widget.subject , title : snapshot.data.documents[index]['title'] , author :snapshot.data.documents[index]['author'] )));
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
}

