import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyLoginPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => MyHomePage(),
        '/home/screen1': (BuildContext context) => Screen1(),
        '/home/screen2': (BuildContext context) => Screen2(),
        '/home/screen3': (BuildContext context) => Screen3(),
      },
    );
  }
}

class MyLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
          child: Text("Push to HomePage"),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = 'Владислав Быков';
  Color newColor = Colors.red;

  void _changeColor(Color value) {
    setState(() {
      newColor = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Navigation")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/home/screen1');
                },
                child: Text("Push to Screen 1"),
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Screen2(
                            userName: userName,
                          )));
                },
                child: Text("Push to Screen 2"),
              ),
            ),
            Container(
              child: RaisedButton(
                color: newColor,
                onPressed: () async {
                  newColor = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen3()),
                  );
                  _changeColor(newColor);
                },
                child: Text("Push to Screen 3"),
              ),
            ),
          ],
        )));
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
              },
              child: Text("Back to login"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Использование метода pushNamedAndRemoveUntil() для возвращения на MyLoginPage',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  Screen2({this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Hello, $userName'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Использование pushNamed() и пробрасывание данных в дочерний экран',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3 - Click!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(
                      context,
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0));
                },
                child: Text('Change color!'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Пробрасывание данных в родительский экран',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }
}
