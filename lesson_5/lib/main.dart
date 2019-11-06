import 'dart:math';

import 'package:flutter/material.dart';

final random = new Random();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главное Окно'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
                child: Text('Открыть второе окно'),
                onPressed: () {
                  final number = random.nextInt(100);
                  print('$number');
                  Navigator.pushNamed(
                    context,
                    '/second/$number',
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String _id;

  SecondScreen({String id}) : _id = id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Второе Окно - $_id'),
      ),
      body: Center(
        child: RaisedButton(
            child: Text('Задать число'),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, _, __) => MyPopup(),
                ),
              );
            }),
      ),
    );
  }
}

class MyPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Все хорошо'),
      actions: [
        FlatButton(onPressed: () {}, child: Text('Кнопка 1')),
        FlatButton(onPressed: () {}, child: Text('Кнопка 2')),
      ],
    );
  }
}

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/second': (context) => SecondScreen(),
        },
        onGenerateRoute: (routeSettings) {
          final route = routeSettings.name;
          print(route);
          final path = route.split('/');
          print(path);
          if (path[1] == 'second') {
            return MaterialPageRoute(
              builder: (context) => SecondScreen(id: path[2]),
              settings: routeSettings,
            );
          }
          return null;
        },
      ),
    );
