import 'package:auth/screens/home/DonersList.dart';
import 'package:auth/services/addBook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailedBook extends StatefulWidget {
    const DetailedBook({ Key key , @required this.semester , @required this.department , @required this.subject , @required this.title , @required this.author}) : super(key: key);
    final department;
    final semester;
    final subject;
    final title;
    final author;
  @override
  _DetailedBookState createState() => _DetailedBookState();
}

class _DetailedBookState extends State<DetailedBook> {
  final databaseReference = Firestore.instance;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int ind;
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
      title: Text('More Info'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          SizedBox(width: 10),
        ],
      ),
      body : Center(
        child: StreamBuilder(
          stream : Firestore.instance.collection('books')
          .where('subject' ,isEqualTo: widget.subject )
          .where('department' , isEqualTo: widget.department)
          .where('semester' , isEqualTo: widget.semester)
          .where('title' , isEqualTo: widget.title)
          .where('author', isEqualTo: widget.author )
          .snapshots(),
          builder: (context , snapshot){
              if(!snapshot.hasData) return Text('Loading ...');
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context , index){
                  ind = index;
                  return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color:  Color.fromRGBO(0,128,128, .9) ,
                      elevation: 27.0,
                      margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal : 15.0 , vertical: 40),
                          child: Column(
                            children: <Widget>[
                               Text(
                                  snapshot.data.documents[index]['title'].toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 22),
                                  ),
                                  SizedBox(height: 15),
                                  Text(snapshot.data.documents[index]['author'].toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white , fontStyle: FontStyle.italic ),
                                  ),
                                  SizedBox(height: 20),
                              Text(
                                widget.subject,
                                 style: TextStyle(color: Colors.white , fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 20),
                              Text(
                                widget.department,
                                 style: TextStyle(color: Colors.white , fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 20),
                              Text(
                                widget.semester,
                                 style: TextStyle(color: Colors.white , fontStyle: FontStyle.italic),
                              ),
                               SizedBox(height: 30),
                              Container(
                          height: 43.0,
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 1.0
                                    ),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context , MaterialPageRoute(
                                      builder: (context)=>
                                       DonerList(department: widget.department, semester: 
                                       widget.semester, subject: widget.subject , title : 
                                       widget.title , author :widget.author , ind : ind 
                                       )
                                    ));
                                  },
                                  child: Center(
                                    child: Text('Get Books',
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color : Colors.white
                                  )
                                ),
                              )
                            )
                          )  
                        ),
                            ],
                          ),
                        ),
                      ),
                  );
                }
              );
          },
        ),
      ),
      bottomNavigationBar: makeBottom,
      );
  }
}