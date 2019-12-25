import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Entry {
  String api;
  String description;
  String auth;
  bool https;
  String cors;
  String link;
  String category;

  Entry(this.api, this.description, this.auth, this.https, this.cors, this.link, this.category);

  Entry.fromJson(Map<String, dynamic> json)
      : api = json['API'],
        description = json['Description'],
        auth = json['Auth'],
        https = json['HTTPS'],
        cors = json['Cors'],
        link = json['Link'],
        category = json['Category'];
}

class TestHttp extends StatefulWidget {
  final String empId;

  TestHttp({String url}) : empId = url;

  @override
  State<StatefulWidget> createState() => TestHttpState();
} // TestHttp

class TestHttpState extends State<TestHttp> {
  final _formKey = GlobalKey<FormState>();

  Entry _entry;

  @override
  void initState() {
    super.initState();
  } //initState

  _sendRequestGet() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); //update form data
      print('Try send request');
      http.get('https://api.publicapis.org/entries').then((response) {
        print(response.body);
        var entriesMap = jsonDecode(response.body);
        var first = (entriesMap['entries'] as List).first;
        print(first.toString());
        _entry = Entry.fromJson(first);


        setState(() {}); //reBuildWidget
      }).catchError((error) {
        print(error);
        setState(() {}); //reBuildWidget
      });
    }
  } //_sendRequestGet

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                RaisedButton(
                    child: Text('Get first entry'),
                    onPressed: _sendRequestGet,
                    padding: EdgeInsets.all(10.0)),
                SizedBox(height: 20.0),
                Text('API',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Text(_entry != null ? _entry.api : ''),
                SizedBox(height: 20.0),
                Text('Description',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Text(_entry != null ? _entry.description : ''),
                SizedBox(height: 20.0),
                Text('Auth',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Text(_entry != null ? _entry.auth : ''),
                SizedBox(height: 20.0),
                Text('HTTPS',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Text(_entry != null ? _entry.https.toString() : ''),
                SizedBox(height: 20.0),
                Text('Cors',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Text(_entry != null ? _entry.cors : ''),
                SizedBox(height: 20.0),
                Text('Link',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Text(_entry != null ? _entry.link : ''),
                SizedBox(height: 20.0),
                Text('Category',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Text(_entry != null ? _entry.category : ''),
                SizedBox(height: 20.0),
              ],
            )));
  } //build
} //TestHttpState

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test HTTP API'),
        ),
        body: TestHttp(url: ''));
  }
}

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
