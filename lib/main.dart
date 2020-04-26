import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:statusbar/statusbar.dart';
import 'package:url_launcher/url_launcher.dart';

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
    var moonLanding = DateTime.parse("2020-05-24 00:00:00Z");
    // print(now.isAfter(moonLanding));
    check = now.isAfter(moonLanding);
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _applaunch() async {
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
      if (!(url.startsWith("http:") || url.startsWith("https:"))) {
        flutterWebviewPlugin.goBack();
        print("back");
        _launchURL(url);
      }
    });
  }

  void initState() {
    fun();
    _applaunch();
    super.initState();

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
        allowFileURLs: true,
        primary: true,
        
        enableAppScheme: true,
        initialChild: Image.asset(
          'asset/logo.jpg',
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width + 1,
          height: MediaQuery.of(context).size.height + 1,
        ),
      ));
    }
  }
}
