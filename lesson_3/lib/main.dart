import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
          child: MyBody(),
        )),
      ),
    );

class MyBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyBodyState();
}

class MyBodyState extends State<MyBody> {
//  List<double> _array = [];
  List<int> _array = [];
  int _exp = 2;

  @override
  Widget build(BuildContext context) =>
      ListView.builder(itemBuilder: (context, i) {
//        print('num $i : isOdd = ${i.isOdd}');
//
//        if (i.isOdd) return Divider();
//
//        final int index = pow(i, _exp);
//
//        print('index $index');
//        print('length ${_array.length}');
//
//        if (index >= _array.length) _array.addAll(
//            ['$index', '${index + 1}', '${index + 2}']);

//        final double index = pow(i, _exp).toDouble();
        final int index = pow(i, _exp);
        // final int index = index * index;

        print('index $i result $index');
        print('${_array.length}');
        if (i >= _array.length) _array.add(index);
        print('$_array');

        return ListTile(
          title: Text(' $i ^ $_exp = ${_array[i]} '),
          subtitle: Divider(),
        );
      });
}
