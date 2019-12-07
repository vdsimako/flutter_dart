import 'package:flutter/material.dart';

class SandGlass {
  int _sand = 0;

  time() {
    return _sand;
  }

  tick () async {
    _sand = 100;
    print('Start:tick');
    while(_sand > 0) {
      print('tick: _sand');
      _sand--;
      await new Future.delayed(const Duration(milliseconds: 100));
    }
    print('End:tick');
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State {
  SandGlass clock = SandGlass();
  _reDrawWidget() async {
    if(clock.time() == 0) return;
    await new Future.delayed(const Duration(seconds: 1));
    setState(() {print('reDrawWidget()');});
  }
  @override
  void initState() {
    clock.tick();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _reDrawWidget();
    print('clock.tick: ${clock.time()}');
    return Center(child: Text('time is: ${clock.time()}'));
  }
}

void main() => runApp(new MaterialApp(home:Scaffold(body: MyApp())));
