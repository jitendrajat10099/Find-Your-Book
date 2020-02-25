import 'package:auth/screens/home/showDonorDetails.dart';
import 'package:auth/services/addBook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonerList extends StatefulWidget {
   const DonerList({ Key key , @required this.semester , @required this.department , @required this.subject , @required this.title , @required this.author, @required this.ind}) : super(key: key);
    final department;
    final semester;
    final subject;
    final title;
    final author;
    final ind;
  @override
  _DonerListState createState() => _DonerListState();
}

class _DonerListState extends State<DonerList> {
  final databaseReference = Firestore.instance;
  bool isExpended = false;
  String user;
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
                      title: Text('List of Donors'),
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
                        .where('title' , isEqualTo: widget.title)
                        .where('author' , isEqualTo: widget.author)
                        .snapshots(),
                        builder: (context , snapshot){
                            if(!snapshot.hasData) return Text('Loading ...');
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.documents[widget.ind]['users'].length,
                              itemBuilder: (context , index){
                              return  ExpansionTile(
                                      title: Text(
                                            snapshot.data.documents[widget.ind]['users'][index]['user'].toUpperCase(),
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 18),
                                      ),
                                      onExpansionChanged: (bool expending) => setState(
                                        ()=> this.isExpended = expending),
                                      trailing: Icon(Icons.keyboard_arrow_down ,
                                        color : isExpended ? Colors.teal : Colors.white,
                                      ),
                                      children: <Widget>[
                                      ShowDonor(department: widget.department, semester: widget.semester, subject: widget.subject , title : widget.title , author :widget.author , ind : widget.ind , user : snapshot.data.documents[widget.ind]['users'][index]['user'] ).getDonorDetails(),
                                ],
                              );
                            }
                          );
                        },
                      ),
                      bottomNavigationBar: makeBottom,
                    );
                  }
                }
                