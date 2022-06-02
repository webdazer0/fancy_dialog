import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const List<Key> keys = [
  Key("Fancy"),
  Key("Flat"),
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: ElevatedButton(
              key: keys[0],
              child: Text(
                "Fancy Dialog",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => FancyDialog(
                          defaultButtons: false,
                          actionButtons: ElevatedButton(
                              key: testKeys[0],
                              onPressed: () {},
                              child: Text('Your custom button')),
                          cancelFun: () {
                            print('Active');
                          },
                          title: "Fancy Gif Dialog",
                          description:
                              "This is description for fancy gif,you can load any image or gif to be displayed :), and you can choose between two themes Fancy and Flat",
                          animationType: FancyAnimation.BOTTOM_TOP,
                          theme: FancyTheme.FANCY,
                          gifPath: FancyGif.MOVE_FORWARD, //'./assets/walp.png',
                          okFun: () {
                            print("it's working :)");
                          },
                        ));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: ElevatedButton(
              key: keys[1],
              child: Text(
                "Flat Dialog",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => FancyDialog(
                          key: testKeys[1],
                          title: "Fancy Gif Dialog",
                          titleTextStyle:
                              TextStyle(color: Colors.red, fontSize: 25),
                          description:
                              "This is descreption for fancy gif,you can load any image or gif to be displayed :), and you can choose between two themes Fancy and Flat",
                          animationType: FancyAnimation.BOTTOM_TOP,
                          theme: FancyTheme.FLAT,
                          gifPath: FancyGif.MOVE_FORWARD, //'./assets/walp.png',
                          okFun: () {
                            print("it's working :)");
                          },
                        ));
              },
            ),
          )
        ],
      ),
    ));
  }
}
