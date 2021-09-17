import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/model/post.dart';
import 'package:pushnotification/services/RTDBservice.dart';

class CommitPost extends StatefulWidget {
  const CommitPost({Key? key}) : super(key: key);

  @override
  _CommitPostState createState() => _CommitPostState();
}

class _CommitPostState extends State<CommitPost> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Create a new post"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: textEditingController1,
              decoration: InputDecoration(hintText: "Firstname"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: textEditingController2,
              decoration: InputDecoration(hintText: "Lastname"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: textEditingController3,
              decoration: InputDecoration(hintText: "Content"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: textEditingController4,
              decoration: InputDecoration(hintText: "Date"),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                onPressed: () async{

                  
                var res= await RTDBService.addPost(new  Post(
                      id: Random().nextInt(100).toString(),
                      name: textEditingController1.text,
                      surname: textEditingController2.text,
                      message: textEditingController3.text,
                      time: textEditingController4.text));
                print(res);
                 Navigator.pop(context);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
