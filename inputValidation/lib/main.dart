import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  final _text = TextEditingController();
  final _text2 = TextEditingController();
  bool _validate = false;
  bool _validate2 = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _text,
              decoration: InputDecoration(
                labelText: 'Enter the Value',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
              ),
            ),
            TextField(
              controller: _text2,
              decoration: InputDecoration(
                labelText: 'Enter the Value',
                errorText: _validate2 ? 'Value Can\'t Be Empty' : null,
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _text.text.isEmpty ? _validate = true : _validate = false;
                  _text2.text.isEmpty ? _validate2 = true : _validate2 = false;
                });
              },
              child: Text('Submit'),
              textColor: Colors.white,
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
