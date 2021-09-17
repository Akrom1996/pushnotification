import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:pushnotification/model/post.dart';

class RTDBService {
  static final _database = FirebaseDatabase.instance.reference();

  static Future<Stream<Event>> addPost(Post post) async {
    print("posting data ${post.surname}");
    await _database.child("posts").push().set(post.toJson());

    return _database.onChildAdded;
  }

  static Future<List<Post>> getPosts() async {
    List<Post> items = [];
    Query _query = _database.reference().child("posts"); //.equalTo(id);

    // _query.onValue.listen((event) {
    //   var snapshot = event.snapshot;
    //
    //   snapshot.value.values.forEach((value) {
    //     print('Value is $value');
    //     items.add(Post.fromJson(Map<String, dynamic>.from(value)));
    //   });
    //   print("items: $items");
    // });
    // return items;
    var snapshot = await _query.once();
    print("query: ${snapshot.value.values}");
    snapshot.value.values.forEach((val) {
      print(val.runtimeType);
      items.add(Post.fromJson( Map<String, dynamic>.from(val)));

    });
    // var result = snapshot.value.values as Iterable;
    //
    // for (var item in result) {
    //   items.add(Post.fromJson(item));
    // }
    return items;
  }
}
