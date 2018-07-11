import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'post.dart';
import 'widget_posts_list.dart';

Future<List<Post>> fetchPost(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/posts');

  // Use the compute function to run parsePosts in a separate isolate
  return compute(parsePost, response.body);
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: new Text("Evaluation demo",
              style: new TextStyle(color: Colors.white)),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(12.0),
              child: new Text(
                  "Http json response from https://jsonplaceholder.typicode.com/posts to list view",
                  style: new TextStyle(color: Colors.white70)))),
      body: FutureBuilder<List<Post>>(
        future: fetchPost(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PostsList(posts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
