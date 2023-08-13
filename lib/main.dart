import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formstudent/getu.dart';
import 'package:formstudent/search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        
          resizeToAvoidBottomInset: false,
      appBar: AppBar(
        
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text('STUDENTS FORM'),
        // actions: <Widget>[
        //   IconButton(onPressed:(){
        //      Navigator.push(
        //           context,
        //           // NoteUpdateScreen().NoteUpdateScree(widget.doc["doc_id"]));
        //           MaterialPageRoute(builder: (context) => NoteEditorScreen()));
                
        //     // Navigator.pop(context);
        //     },
        //    icon: Icon(Icons.search)),
        // ],
      ),
      body: Myform(),
    ));
  }
}

class Myform extends StatefulWidget {
  const Myform({super.key});
  @override
  State<Myform> createState() => _MyformState();
}

class _MyformState extends State<Myform> {
  File? image;
  Future _getFromCamera() async {
    final pickerFile =await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickerFile == null) return;
    final i = File(pickerFile.path);
     setState(() {
      image = i;
    });
    // setState(() {

    // d=pickerFile;
    // });
    // Image(pickerFile.path);

    // Navigator.pop(context);
  }

  Future _getFromGallery() async {
    final pickerFile =await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerFile == null) return;
    final i = File(pickerFile.path);
    setState(() {
      image = i;
    });
    // Navigator.pop(context);
  }

  // final _form = GlobalKey<FormState>();
  TextEditingController _id = TextEditingController();
  TextEditingController _roll = TextEditingController();
  TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String val;
    // key: _form,
    return Container(
padding: EdgeInsets.all(30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      
      children: [
        // Image.file(d),
        // Spacer(),
        
        image!=null?
        Image.file(
          image!,
          width: 190,
          height: 190,
          fit: BoxFit.cover,
          
        ):FlutterLogo(size:160),
        // Spacer(),
        TextField(
          // validator: (value) {
          // val = value;
          controller: _id,
          decoration:
              InputDecoration( hintText: 'STUDENT ID',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue)

              )
              ),
          //     border:
          // cursorColor: Colors.black,
        ),
        SizedBox(height: 10.0),
        TextField(
          // validator: (value) {
          // val = value;
          controller: _roll,
         decoration:
              InputDecoration( hintText: 'STUDENT ROLL',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue)

              )
              ),
        ),
        SizedBox(height: 10.0),
        TextField(
          // validator: (value) {
          // val = value;
          controller: _email,
          decoration:
              InputDecoration( hintText: 'STUDENT EMAIL',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue)
              )
              ),
        ),
        SizedBox(height: 10.0),
        // val=_id.text;
        // if (_id.text) {
        //   return 'Please enter a valid Student Name';
        // };
        
        ElevatedButton(
          // Text('Submit'),
          onPressed: () {
            // if (_form.currentState!.validate()) {
            // Firebase
            
            FirebaseFirestore.instance.collection('Student').add({
              'student_id': _id.text,
              'student_roll': _roll.text,
              'email_id': _email.text,
              'img_loc': image!.path,
            }).then((value){
               print(value.id);
            final doct =
                FirebaseFirestore.instance.collection("Student").doc(value.id);
            doct.update({
              'doc_id': value.id,
            });
            }).catchError(
              (error) => print("Failed to add new Node due to $error")
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
            // }
          },

          child: Text('SUBMIT'),
        ),
        ElevatedButton(
          // Text('Submit'),
          onPressed: () {
            // context: context;
            _getFromCamera();
            
            // Navigator.pop(context);
            // if (_form.currentState!.validate()) {
            // Firebase
            // FirebaseFirestore.instance.collection('Student').add({
            //   'student_id': _id.text,
            //   'student_roll': _roll.text,
            //   'email_id': _email.text,
            // });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Adding image Data')),
            );
            // }
          },
          

          child: Text('CAMERA'),
        ),
        
        FloatingActionButton(onPressed:()async{
           Navigator.push(
                  context,
                  // NoteUpdateScreen().NoteUpdateScree(widget.doc["doc_id"]));
                  MaterialPageRoute(builder: (context) => NoteEditorScreen()));
                
            // Navigator.pop(context);
            },
            child: Icon(Icons.search),
        )
        // )
        //  ElevatedButton(
        //   // Text('Submit'),
        //   onPressed: () {
        //     // context: context;
        //     _getFromGallery();
        //     // Navigator.pop(context);
        //     // if (_form.currentState!.validate()) {
        //     // Firebase
        //     // FirebaseFirestore.instance.collection('Student').add({
        //     //   'student_id': _id.text,
        //     //   'student_roll': _roll.text,
        //     //   'email_id': _email.text,
        //     // });

        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('Adding image Data')),
        //     );
        //     // }
        //   },

        //   child: Text('GALLERY'),
        // )
      ],
    ),
  
    );
    
    // )
  }
  
}
