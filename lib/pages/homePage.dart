import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import 'package:pushnotification/model/post.dart';
import 'package:pushnotification/pages/signInPage.dart';
import 'package:pushnotification/services/RTDBservice.dart';
import 'package:pushnotification/services/authService.dart';
import 'package:pushnotification/services/prefsService.dart';

import 'commitPost.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Stream loadData() {
  //   return loadPosts().asStream();
  // }

  Stream<List<Post>> loadPosts() async* {
    var items = await RTDBService.getPosts( );
    print("items: $items");
    yield items;
  }

  Future signOut() async {
    AuthService.signOutUser(context);
    Navigator.pushReplacementNamed(context, SignIn.id);
  }

  Future getId() async {
    return await Prefs.loadUserId();
  }

  List<Post> items = [];
  var id=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  static final _database = FirebaseDatabase.instance.reference();
  Query _query = _database.reference().child("posts");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All posts",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
              onPressed: signOut,
              icon: Icon(
                Icons.exit_to_app_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream:  _query.onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print("posts: ${snapshot.data}");
            if(snapshot.data!=null) {
              var data = snapshot.data.snapshot.value.values;
              List<Post> items = [];
              data.forEach((val) {
                print(val.runtimeType);
                items.add(Post.fromJson( Map<String, dynamic>.from(val)));
              });
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          "${items[index].name} ${items[index].surname}"),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CommitPost()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}
