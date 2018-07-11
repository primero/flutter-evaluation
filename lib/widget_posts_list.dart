import 'package:flutter/material.dart';
import 'post.dart';
import 'widget_post.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;

  PostsList({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return WidgetPost(
            posts[index].body, posts[index].title, posts[index].id.toString());
      },
    );
  }
}
