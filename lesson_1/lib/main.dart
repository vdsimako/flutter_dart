import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          new Text('Hello World!'),
          new FlatButton(
            onPressed: () async {
              const url = 'https://flutter.su';
              if (await(canLaunch(url))) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Text('open site'),
            color: Colors.red,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter.su'),
          ),
          body: MyBody()
      )
  )
  );
}
