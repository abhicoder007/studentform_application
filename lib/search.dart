// import 'dart:html';
// import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package: formstudent/lib/getu.dart';
import 'package:formstudent/getu.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

List<String> u = [];
int p = -1;
// File? u

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);
  //  NoteEditorScreen(this.doc, {Key? key}) : super(key: key);
  // QueryDocumentSnapshot doc;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  // int color_id = Random().nextInt(appstyle.cardsColor.length);

  TextEditingController _mainController = TextEditingController();
  // List<String> docIds = [];
  String name = "";
  // Future getDocIds() async {
  //   await FirebaseFirestore.instance
  //       .collection('Student')
  //       .get()
  //       .then((value) => value.docs.forEach((element) {
  //             docIds.add(element.reference.id);
  //           }));
  // }

  // @override
  // void setState() {
  //   // TODO: implement setState
  //   // getDocIds();

  //   super.setState();
  // }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> s;
    // int a = 0;

    return Scaffold(
      // backgroundColor: appstyle.cardsColor[color_id],
      appBar: AppBar(
        // backgroundColor: appstyle.cardsColor[color_id],
        // elevation: 0.0,
        // iconTheme: IconThemeData(color: Colors.blueAccent),
        // title: Text(
        //   "SEARCH UR DETAILS",
        //   style: TextStyle(color: Colors.black),
        // ),
         title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        )
      ),
       body: StreamBuilder<QuerySnapshot>(
        
          stream: FirebaseFirestore.instance.collection('Student').snapshots(),
          builder: (context, snapshots) {
            
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                   padding: EdgeInsets.all(30),
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (name.isEmpty) {
                        return ListTile(
                          trailing: IconButton(onPressed: () {
                             final doct = FirebaseFirestore.instance
                  .collection("Student")
                  .doc(data["doc_id"]);
              // String v = widget.doc["note_title"];
              // doct.update({
              //   'note_title':'hello world'
              // });
              doct.delete();
                          },
                          
                          icon:Icon(Icons.delete)),
                          title: Text(
                            data['student_id'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['student_roll'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(data['img_loc']),
                          // ),
                          leading:
                          // CircleAvatar(
                             Image.file(
                              File(File(data['img_loc']).path),
                              
                            // )
                          ),
                        );
                      }
                      if (data['student_id']
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase())) {
                        return ListTile(
                           trailing: IconButton(onPressed: () {
                             final doct = FirebaseFirestore.instance
                  .collection("Student")
                  .doc(data["doc_id"]);
              // String v = widget.doc["note_title"];
              // doct.update({
              //   'note_title':'hello world'
              // });
              doct.delete();
                          },
                          
                          icon:Icon(Icons.delete)),
                          title: Text(
                            data['student_id'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['student_roll'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading:
                          // CircleAvatar(
                             Image.file(
                              File(File(data['img_loc']).path),
                              fit: BoxFit.cover,
                            // )
                          ),
                        );
                      }
                      return Container();
                    });
          },
        ),
        );
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: <Widget>[
      //     Container(
      //       padding: EdgeInsets.all(30),
      //       child: TextField(
      //           controller: _mainController,
      //           // onTap: () {
      //           //   Navigator.pop(context);
      //           // },

      //           decoration: InputDecoration(
      //               hintText: 'SEARCH UR ROLL NUMBER HERE',
      //               icon: Icon(Icons.search),
      //               border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(20),
      //                   borderSide: const BorderSide(color: Colors.blue))),
      //           // onChanged: searchName,
      //           onChanged: (val) {
      //             setState(() {
      //               name = val;
      //             });
      //           }),
      //     ),
      //     Expanded(
      //         child: FutureBuilder(
      //       future: getDocIds(),
      //       builder: (context, snapshot) {
      //         // getDocIds();
      //         return ListView.builder(
      //             padding: const EdgeInsets.all(10),
      //             itemCount: docIds.length,
      //             itemBuilder: (context, index) {
      //               return Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: ListTile(
      //                   title: GetUserName(documentId: docIds[index]),
      //                   // hoverColor: Colors.amberAccent,
      //                   tileColor: Colors.orange[400],
      //                   // style: Border()
      //                   // leading: Image.file(
      //                   //   File(File(u.elementAt(index)).path),
      //                   //   width: 50,
      //                   //   height: 50,
      //                   //   fit: BoxFit.cover,
      //                   // ),
      //                   // title:
      //                 ),
      //               );
      //             });
      //       },
      //     ))
      //   ],
      // ),
    // );
    // void searchName(String query) {
    //   final suggestions = docIds.where(('Student_id') {

    //   }).toList();
    // }
  }
}
