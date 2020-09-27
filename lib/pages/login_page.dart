import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '登录',
      home: InputArea(),
    );
  }
}

class InputArea extends StatefulWidget {
  // InputArea({Key key, this.title}):  super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputAreaState();
  }
}

class _InputAreaState extends State<InputArea> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        // TextField(),
        SizedBox(
          height: 10,
        ),
        // TextField()
      ],
    );
  }
}
