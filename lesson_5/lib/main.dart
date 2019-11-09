import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    onGenerateRoute: (routeSettings) {
      if (routeSettings.name == PassArgumentsScreen.routeName) {
        final ScreenArguments args = routeSettings.arguments;
        return MaterialPageRoute(builder: (context) {
          return PassArgumentsScreen(
            title: args.title,
            message: args.message,
          );
        });
      }

      var path = routeSettings.name.split('/');

      if (path[1] == "second") {
        return new MaterialPageRoute(
          builder: (context) => new SecondScreen(id: path[2]),
          settings: routeSettings,
        );
      }

      return null;
    },
    routes: {
      '/': (BuildContext context) => MainScreen(),
      '/second': (BuildContext buildContext) => SecondScreen(),
      ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
    },
  ));
}

final Random random = Random();

class MainScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Главный экран",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
            child: Text('Открыть второе окно'),
          ),
          RaisedButton(
            onPressed: () {
              int i = random.nextInt(100);
              Navigator.pushNamed(context, '/second/$i');
            },
            child: Text('Открыть второе окно'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExtractArgumentsScreen(),
                      settings: RouteSettings(
                          arguments:
                              ScreenArguments('testTitle', 'extractMessage'))));
            },
            child: Text('Передать параметры'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                PassArgumentsScreen.routeName,
                arguments: ScreenArguments(
                  'Accept Arguments Screen',
                  'This message is extracted in the onGenerateRoute function.',
                ),
              );
            },
            child: Text('Navigate to a named that accepts arguments'),
          ),
          RaisedButton(
              onPressed: () async {
                final value = await Navigator.push(
                  context,
                  PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) => MyPopup(),
                      transitionsBuilder: (___, Animation<double> animation,
                          ____, Widget child) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      }),
                );

                print('result $value');

                if (value) {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Больше'),
                    backgroundColor: Colors.green,
                  )); // TRUE
                } else {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Меньше'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Text('Загадать число'))
        ],
      )),
    );
  }
}

class MyPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ваш ответ:'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text('Больше'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text('Меньше'),
        )
      ],
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
        title: Text(
          "Второй экран" + ((_id != null && _id.isNotEmpty) ? ' $_id' : ''),
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Назад'),
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    ScreenArguments arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.title),
      ),
      body: Center(
        child: Text(arguments.message),
      ),
    );
  }
}

class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  const PassArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
