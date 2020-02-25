import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowDonor{
    final department;
    final semester;
    final subject;
    final title;
    final author;
    final ind;
    final user;
  const ShowDonor({ @required this.semester , @required this.department ,
   @required this.subject , @required this.title , @required this.author, 
   @required this.ind , @required this.user});

    Widget getDonorDetails() {
      return StreamBuilder(
        stream : Firestore.instance.collection('users')
        // .where( 'user' , isEqualTo: user)
        .snapshots(),
        builder: (context , snapshot){
            // print(department);
            // print(semester);
            // print(subject);
            // print(title);
            // print(author);
            // print(ind);

            if(!snapshot.hasData) return Center(child : Text('Loading ...'));
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context , index){
              return Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                              'Donor Name : ${snapshot.data.documents[index].data['name']}',
                              style: TextStyle(color: Colors.black),
                          ),
                        SizedBox(height: 10),
                        Text(
                              'Donor Contect No : ${snapshot.data.documents[index].data['mobNo']}',
                              style: TextStyle(color: Colors.black),
                          ),
                        SizedBox(height: 10),
                        Text(
                              'Donor Email Id : ${snapshot.data.documents[index].data['email']}',
                              style: TextStyle(color: Colors.black ),
                        ),
                        SizedBox(height: 10),
                        Container(
                        height: 45.0,
                        width: 150,
                        child: Material(
                          borderRadius: BorderRadius.circular(22.0),
                          shadowColor: Color.fromRGBO(58, 66, 86, 1.0),
                          color: Color.fromRGBO(58, 66, 86, 1.0),
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: (){},
                            child: Center(
                              child: Text(
                                'Make Request',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                        SizedBox(height: 20),
                        
                    ],
                  ),
              );
              
            }
      );
    }
    );
    }
}