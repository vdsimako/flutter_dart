import 'package:flutter/material.dart';

Set<String> _units = {'мм', 'см'};

List<DropdownMenuItem<String>> _unitMenuItems = _units.map((String value) {
  return new DropdownMenuItem<String>(
    value: value,
    child: new Text(value),
  );
}).toList();

class MyForm extends StatefulWidget {
  @override
  State createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  int _width;
  int _height;
  int _area;
  String _unitOfMeasure = 'мм';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ширина',
                  labelStyle: TextStyle(fontSize: 20.0),
                ),
                initialValue: '0',
                validator: (value) {
                  var width = int.tryParse(value);

                  if (width == null) return 'Некорректное число';

                  if (width < 0) return 'Ширина не может быть отрицательной';

                  _width = width;

                  return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Длина',
                  labelStyle: TextStyle(fontSize: 20.0),
                ),
                initialValue: '0',
                validator: (value) {
                  var height = int.tryParse(value);

                  if (height == null) return 'Некорректное число';

                  if (height < 0) return 'Длина не может быть отрицательной';

                  _height = height;

                  return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Text(
                    'Введите единицу измерения: ',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  DropdownButton<String>(
                    icon: Icon(Icons.arrow_downward),
                    elevation: 8,
                    items: _unitMenuItems,
                    onChanged: (String value) {
                      _unitOfMeasure = value;
                    },
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    value: _unitOfMeasure,
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                  child: Text('Расчитать площадь', style: TextStyle(fontSize: 20.0),),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _area = _width * _height;
                      });
                    }
                  }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                _area == null
                    ? 'задайте параметры'
                    : 'S = $_width * $_height = ${_area} (${_unitOfMeasure}2)',
                style: TextStyle(fontSize: 20.0),
              )
            ],
          ),
        ));
  }
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Калькулятор площади'),
        ),
        body: MyForm(),
      ),
    ));
