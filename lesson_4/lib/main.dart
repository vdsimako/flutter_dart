import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

enum GenderList { male, female }

class MyForm extends StatefulWidget {
  @override
  State createState() {
    return MyFormState();
  }
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  GenderList _gender;
  bool _agreement = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                "Введите имя пользователя",
                style: TextStyle(fontSize: 20.0),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Имя не может быть пустым";
                  return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Введите email пользователя",
                style: TextStyle(fontSize: 20.0),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Поле Email не может быть пустым";
                  if (!value.contains("@"))
                    return "Поле Email должен содержать '@'";

//                String emailPattern = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
//                RegExp reqExp = RegExp(emailPattern);

                  if (isEmail(value)) return null;

                  return "Неправильный email";
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Ваш пол:',
                style: TextStyle(fontSize: 20.0),
              ),
              RadioListTile(
                  title: const Text('Мужской'),
                  value: GenderList.male,
                  groupValue: _gender,
                  onChanged: (GenderList value) {
                    setState(() {
                      _gender = value;
                    });
                  }),
              RadioListTile(
                  title: const Text('Женский'),
                  value: GenderList.female,
                  groupValue: _gender,
                  onChanged: (GenderList value) {
                    setState(() {
                      _gender = value;
                    });
                  }),
              SizedBox(
                height: 20.0,
              ),
              CheckboxListTile(
                  value: _agreement,
                  title: Text('Я ознакомлен' +
                      (_gender == null
                          ? '(а)'
                          : _gender == GenderList.male ? '' : 'а') +
                      ' с документом "Согласие на обработку персональных данных" '
                          'и даю согласие на обработку моих персональных данных '
                          'в соответствии с требованиями "Федерального закона '
                          'О персональных данных № 152-ФЗ".'),
                  onChanged: (bool value) {
                    setState(() {
                      _agreement = value;
                    });
                  }),
              RaisedButton(
                child: Text("Отправить данные"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Color color = Colors.red;
                    String text;

                    if (_gender == null)
                      text = 'Выберите свой пол';
                    else if (_agreement == false)
                      text = 'Необходимо принять условия соглашения';
                    else {
                      text = 'Форма успешно заполнена';
                      color = Colors.green;
                    }

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(text),
                        backgroundColor: color,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Scaffold(
    appBar: AppBar(title: Text("Lesson4 - Пример формы ввода")),
    body: MyForm(),
  ),
));
