import 'package:flutter/material.dart';

class NewsBox extends StatelessWidget {
  final String _title;
  final String _text;
  String _imageurl;
  int _num;
  bool _like;

  NewsBox(this._title, this._text,
      {String imageurl, int num = 0, bool like = false}) {
    _imageurl = imageurl;
    _num = num;
    _like = like;
  }

  @override
  Widget build(BuildContext context) {
    if (_imageurl != null && _imageurl != '')
      return Container(
        color: Colors.black12,
        height: 100.0,
        child: Row(
          children: [
            Image.network(
              _imageurl,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Text(
                      _title,
                      style: TextStyle(fontSize: 20.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                        child: Text(
                      _text,
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ))
                  ],
                ),
              ),
            ),
            NewsBoxFavourit(_num, _like)
          ],
        ),
      );

    return Container(
      color: Colors.black12,
      height: 100.0,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    _title,
                    style: TextStyle(fontSize: 20.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(
                      child: Text(
                    _text,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ))
                ],
              ),
            ),
          ),
          NewsBoxFavourit(_num, _like)
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('my text');
  }
}

class NewsBoxFavourit extends StatefulWidget {
  final int _num;
  final bool _like;

  NewsBoxFavourit(this._num, this._like);

  @override
  State<StatefulWidget> createState() => NewsBoxFavoriteState(_num, _like);
}

class NewsBoxFavoriteState extends State<NewsBoxFavourit> {
  int num;
  bool like;

  NewsBoxFavoriteState(this.num, this.like);

  void pressButton() {
    setState(() {
      like = !like;

      if (like)
        num++;
      else
        num--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'In favorite $num',
          textAlign: TextAlign.center,
        ),
        IconButton(
            icon: Icon(
              like ? Icons.star : Icons.star_border,
              size: 30.0,
              color: Colors.blue[500],
            ),
            onPressed: pressButton)
      ],
    );
  }
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            NewsBox(
              'New Lesson on Flutter',
              'In new Lesson tels about commonn use cases of classes StatelessWidget & StatefulWidget. Examples provided',
              imageurl: 'https://flutter.su/favicon.png',
              num: 10,
            ),
            NewsBox(
              'New Lesson on Flutter',
              'In new Lesson tels about commonn use cases of classes StatelessWidget & StatefulWidget. Examples provided',
              num: 20,
              like: true,
            ),
          ],
        ),
      ),
    ));
