
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// Widget getContent(BuildContext context) {
//   return StreamBuilder<QuerySnapshot>(
//     stream: Firestore.instance.collection("posts").snapshots(),
//     builder: (context, snap) {

//       //just add this line
//       if(snap.data == null) return CircularProgressIndicator();

//       return (
//         enlargeCenterPage: true,
//         height: MediaQuery.of(context).size.height,
//         items: getItems(context, snap.data.documents),
//     );
//     },
//     );
// }

// List<Widget> getItems(BuildContext context, List<DocumentSnapshot> 
// docs){
//   return docs.map(
//     (doc) {
//       String content = doc.data["content"];
//       return Text(content);
//     }
//   ).toList();
// }