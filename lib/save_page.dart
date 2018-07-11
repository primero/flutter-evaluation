import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'post.dart';
import 'widget_posts_list.dart';

class DataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  Future<String> readPosts() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "Error reading posts:" + e.toString();
    }
  }

  Future<File> writeContents(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(counter);
  }
}

class ReadWritePage extends StatefulWidget {
  final DataStorage storage;

  ReadWritePage({Key key, @required this.storage}) : super(key: key);

  @override
  _ReadWritePageState createState() => _ReadWritePageState();
}

class _ReadWritePageState extends State<ReadWritePage> {
  bool isLoading = true;

  List<Post> posts;
  final _formKey = GlobalKey<FormState>();
  final skey = new GlobalKey<ScaffoldState>();
  String s1 = "";
  String s2 = "";
  @override
  void initState() {
    super.initState();
    widget.storage.readPosts().then((String value) {
      setState(() {
        //print(value);

        try {
          posts = parsePost(value);
        } catch (e) {
          print(e.toString());
          showSnackBar(value.toString());
        }
        isLoading = false;
      });
    });
  }

  Future<File> savePosts() async {
    setState(() {
      isLoading = false;
    });

    // write the variable as a string to the file
    return widget.storage.writeContents(postsToString(posts));
  }

  void showSnackBar(String err) {
    final snackBar = SnackBar(
      content: Text(err),
      duration: const Duration(milliseconds: 1000),
    );
    skey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: new Text("Evaluation demo",
                style: new TextStyle(color: Colors.white)),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(12.0),
                child: new Text(
                    "Read file as json string to list view / add entry to file and update list view",
                    style: new TextStyle(color: Colors.white70)))),
        key: skey,
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.blue,
          //mini: true,
          child: new Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showDialog(
                context: context,
                child: new AlertDialog(
                    title: new Text("Add new entry"), content: makeForm()));
          },
        ),
        body: !isLoading
            ? Container(
                child: Column(children: <Widget>[
                //
                //makeForm(),
                //Expanded( child:Card ( child:RaisedButton(child: Text("Add"),onPressed: showDialog,))),
                Expanded(
                    child:
                        posts == null ? Text("") : PostsList(posts: this.posts))
              ]))
            : Center(child: CircularProgressIndicator()));
  }

  Widget makeForm() {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            initialValue: "title",
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return 'Add entry';
              } else
                s1 = value;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            initialValue: "body",
            autofocus: false,
            validator: (value) {
              if (value.isEmpty) {
                return 'Add entry';
              } else
                s2 = value;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Colors.lightBlueAccent.shade100,
              elevation: 5.0,
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, we want to show a Snackbar
                    setState(() {
                      if (posts == null) {
                        posts = new List<Post>();
                      }
                      int genId = posts.length;
                      Post p = new Post(
                          title: s1, body: s2, userId: genId, id: genId);
                      posts.add(p);
                      savePosts();
                      Navigator.pop(context, "Done");
                      showSnackBar("Saved");
                      //isLoading = true;
                    });
                  }
                },
                color: Colors.lightBlueAccent,
                child: Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Colors.lightBlueAccent.shade100,
              elevation: 5.0,
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, we want to show a Snackbar
                    setState(() {
                      posts = new List<Post>();

                      savePosts();
                      showSnackBar("Saved");
                      Navigator.pop(context, "Done");
                      //isLoading = true;
                    });
                  }
                },
                color: Colors.lightBlueAccent,
                child:
                    Text('Delete all', style: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
