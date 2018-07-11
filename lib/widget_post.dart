import 'package:flutter/material.dart';

class WidgetPost extends StatefulWidget {
  final String title;
  final String body;
  final String id;
  WidgetPost(this.body, this.title, this.id);
  @override
  createState() => new WidgetPostState(body, title, id);
}

class WidgetPostState extends State<WidgetPost> {
  String title;
  String body;
  String id;
  WidgetPostState(this.body, this.title, this.id);

  @override
  Widget build(BuildContext context) {
    return new Card(
        elevation: 5.0,
        child: new Container(
          padding: const EdgeInsets.all(32.0),
          child: new Column(
            children: <Widget>[
              Text("Item index $id",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              Row(
                children: <Widget>[
                  Text(
                    "Title: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Body: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                    body,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ))
                ],
              )
            ],
          ),
        ));
  }
}
