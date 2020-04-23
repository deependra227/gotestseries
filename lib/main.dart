import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:statusbar/statusbar.dart';

import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App By Deependra Chansoliya',
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyHomePage(title: 'Android App By Deependra Chansoliya'),
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
  TextEditingController controller = TextEditingController();
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool check = false;
  Future<void> fun() async {
    DateTime now = DateTime.now();
    var moonLanding = DateTime.parse("2020-04-23 00:00:00Z");
    // print(now.isAfter(moonLanding));
    check = now.isAfter(moonLanding);
  }

  void initState() {
    super.initState();
    fun();
    // check = fun();
    // print('no');
    StatusBar.color(Color.fromRGBO(196, 40, 39, 0));
    flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        flutterWebviewPlugin.resize(Rect.fromLTRB(
          MediaQuery.of(context).padding.left,

          /// for safe area
          MediaQuery.of(context).padding.top,

          /// for safe area
          MediaQuery.of(context).size.width + 1,

          MediaQuery.of(context).size.height + 1,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fun();
    if (check == true) {
      return Container(
        child: Text(" "),
      );
    } else {
      return SafeArea(
          child: WebviewScaffold(
        url: "https://www.gotestseries.com/",
        withJavascript: true,
        withZoom: false,
        hidden: true,
        scrollBar: false,
        appCacheEnabled: true,
        initialChild: Image.asset(
          'asset/logo.jpg',
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width + 1,
        ),
      ));
    }
  }
}

bool fun() {
  DateTime now = DateTime.now();
  var moonLanding = DateTime.parse("2969-07-20 20:18:04Z");
  print(now.isAfter(moonLanding));
  return now.isAfter(moonLanding);
}
