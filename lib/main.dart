import 'package:flutter/material.dart';
import 'package:statusbar/statusbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  bool check = false;

  Future<void> fun() async {
    DateTime now = DateTime.now();
    var moonLanding = DateTime.parse("2020-05-24 00:00:00Z");
    // print(now.isAfter(moonLanding));
    check = now.isAfter(moonLanding);
  }

  _launchURL(url) {
    if (canLaunch(url) != null) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  var url = "https://www.gotestseries.com/";

  void initState() {
    fun();
    super.initState();
    StatusBar.color(Color.fromRGBO(196, 40, 39, 0));
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  backFunction(
      BuildContext context, AsyncSnapshot<WebViewController> controller) {
    controller.data.goBack();
  }

  @override
  Widget build(BuildContext context) {
    fun();
    if (check == true) {
      return Container(
        child: Text(" "),
      );
    } else {
      return FutureBuilder<WebViewController>(
          future: _controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> controller) {
            return SafeArea(
              child: WillPopScope(
                onWillPop: () => backFunction(context, controller),
                child: Scaffold(
                  bottomNavigationBar: BottomAppBar(
                    elevation: 0.0,
                    child: ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.flash_on),
                            iconSize: 29,
                            onPressed: () {
                              controller.data.loadUrl(
                                  "https://gotestseries.com/index.php");
                            }),
                        IconButton(
                            icon: Icon(Icons.local_library),
                             iconSize: 29,
                            onPressed: () {
                              controller.data.loadUrl(
                                  "https://gotestseries.com/tests.php");
                            }),
                        IconButton(
                            icon: Icon(Icons.search),
                             iconSize: 29,
                            onPressed: () {
                              controller.data.loadUrl(
                                  "https://gotestseries.com/search.php");
                            }),
                        IconButton(
                            icon: Icon(Icons.insert_chart),
                             iconSize: 29,
                            onPressed: () {
                              controller.data.loadUrl(
                                  "https://gotestseries.com/results.php");
                            }),
                        IconButton(
                            icon: Icon(Icons.person),
                             iconSize: 29,
                            onPressed: () {
                              controller.data.loadUrl(
                                  "https://gotestseries.com/profile.php");
                            }),
                      ],
                    ),
                  ),
                  backgroundColor: Color.fromRGBO(196, 40, 39, 1),
                  body: WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    gestureNavigationEnabled: true,
                    navigationDelegate: (NavigationRequest request) {
                      if (!(request.url.startsWith("http:") ||
                          request.url.startsWith("https:"))) {
                        _launchURL(request.url);
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                ),
              ),
              top: true,
            );
          });
    }
  }
}
