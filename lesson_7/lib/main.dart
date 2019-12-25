import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  User(this.id, this.email, this.firstName, this.lastName, this.avatar);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        avatar = json['avatar'];
}

class TestHttp extends StatefulWidget {
  final String empId;

  TestHttp({String url}) : empId = url;

  @override
  State<StatefulWidget> createState() => TestHttpState();
} // TestHttp

class TestHttpState extends State<TestHttp> {
  final _formKey = GlobalKey<FormState>();

  String _empId, _avatarUrl;
  User _user;

  @override
  void initState() {
    _empId = widget.empId;
    super.initState();
  } //initState

  _sendRequestGet() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); //update form data
      print('Try send request');
      http.get('https://reqres.in/api/users/$_empId').then((response) {
        print(response.body);
        var employeeMap = jsonDecode(response.body);
        _user = User.fromJson(employeeMap['data']);
        print('${_user.lastName}');
        _avatarUrl = _user.avatar;

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
                      Container(
                          child: Text('Employee Id:',
                              style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                          padding: EdgeInsets.all(10.0)),
                      Container(
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) return 'Employee Id isEmpty';
                                return null;
                              },
                              onSaved: (value) {
                                _empId = value;
                              },
                              autovalidate: true),
                          padding: EdgeInsets.all(10.0)),
                      RaisedButton(
                          child: Text('Get user info'),
                          onPressed: _sendRequestGet,
                          padding: EdgeInsets.all(10.0)),
                      SizedBox(height: 20.0),
                      Text('First Name',
                          style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                      Text(_user != null ? _user.firstName : ''),
                      SizedBox(height: 20.0),
                      Text('Last Name',
                          style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                      Text(_user != null && _user.lastName != null ? _user.lastName : ''),
                      Text('Email:',
                          style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                      Text(_user != null && _user.email != null ? _user.email : ''),
                      Text('Avatar:',
                          style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                      Image.network(_avatarUrl == null ? '' : _avatarUrl)
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
