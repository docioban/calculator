import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 112, 193, 179),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var rez;
  String semn = "";
  var nr1;
  var nr2;
  bool is_double = false;

  String output = "0";
  String _output = "0";

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      rez = 0;
      semn = "";
      nr1 = 0;
      nr2 = 0;
      _output = "0";
    } else if (buttonText == ".") {
      if (!_output.contains("."))
        _output = _output + buttonText;
      is_double = true;
    } else if (buttonText == '+/-') {
      if (is_double)
        _output = (double.parse(_output) * -1.0).toString();
      else
        _output = (int.parse(_output) * -1).toString();
    } else if ( buttonText == "/" || buttonText == "X" || buttonText == "-" || buttonText == "+") {
      if (is_double) {
        nr1 = double.parse(_output);
        is_double = false;
      }
      else
        nr1 = int.parse(_output);
      semn = buttonText;
      _output = "0";
    } else if (buttonText == "√") {
      if (is_double)
        nr1 = double.parse(_output);
      else
        nr1 = int.parse(_output);
      rez = sqrt(nr1);
      _output = rez.toString();
    } else if (buttonText == "=") {
      if (is_double) {
        nr2 = double.parse(_output);
        is_double = false;
      } else
        nr2 = int.parse(_output);
      if (semn == "+")
        rez = nr1 + nr2;
      else if (semn == "-")
        rez = nr1 - nr2;
      else if (semn == "/") {
        if (nr1 % nr2 != 0)
          rez = nr1 / nr2;
        else
          rez = nr1 ~/ nr2;
      }
      else if (semn == "X")
        rez = nr1 * nr2;
      _output = rez.toString();
    } else
      _output = _output + buttonText;

    setState(() {
      if (_output.contains('.'))
        output = double.parse(_output).toString();
      else
        output = int.parse(_output).toString();;
      if (buttonText == "=" || buttonText == "√")
        _output = "0";
    });
  }

  Widget buildButton(String buttonText) {
    return new Expanded(
      child: new MaterialButton(
        child: new Text(
            buttonText,
          style: TextStyle(
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: new EdgeInsets.all(33.0),
        color: const Color.fromARGB(255, 36, 123, 160),
        textColor: const Color.fromARGB(255, 255, 224, 102),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              alignment: Alignment.centerRight,
              padding: new EdgeInsets.only(
                top: 80.0,
                right: 10.0,
              ),
              child: new Text(
                "$output",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45.0,
                  color: const Color.fromARGB(255, 242, 95, 92),
                ), maxLines: 1,
              ),
            ),
            new Expanded(child: new Divider()),

            new Row(
              children: <Widget>[
                buildButton('C'),
                buildButton('+/-'),
                buildButton('√'),
                buildButton('/'),
              ]
            ),
            new Row(
                children: <Widget>[
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('X'),
                ]
            ),
            new Row(
                children: <Widget>[
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('-'),
                ]
            ),
            new Row(
                children: <Widget>[
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('+'),
                ]
            ),
            new Row(
                children: <Widget>[
                  buildButton('0'),
                  buildButton('.'),
                  new Expanded(
                    flex: 2,
                    child: new MaterialButton(
                      child: new Text(
                        '=',
                        style: TextStyle(
                          fontSize: 27.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: new EdgeInsets.all(33.0),
                      color: const Color.fromARGB(255, 36, 123, 160),
                      textColor: const Color.fromARGB(255, 178, 219, 191),
                      onPressed: () => buttonPressed('='),
                    ),
                  ),
                ]
            ),

          ],
        ),
      )
    );
  }
}
