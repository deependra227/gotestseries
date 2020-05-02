import 'dart:io';

import 'package:flutter/material.dart';
import 'package:statusbar/statusbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

void main() => runApp(MyApp());
var connectionStatus = true;

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

  bool isLoading;
  var url = "https://www.gotestseries.com/";
  final Connectivity _connectivity = Connectivity();

  void initState() {
    fun();
    isLoading = true;
    super.initState();
    StatusBar.color(Color.fromRGBO(196, 40, 39, 0));
    _connectivity.onConnectivityChanged.listen(_updateConnection);
  }

  alertDialogBack(
      BuildContext context, AsyncSnapshot<WebViewController> controller) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          // title: Text(""),
          content: Text("Check Your Internet Connection"),
          actions: [
            FlatButton(
              onPressed: () async {
                // var currentURL = controller.data.currentUrl();
                await che();
                if (connectionStatus == true) {
                  controller.data.goBack();
                }
                Navigator.of(context).pop();
              },
              child: Text("Reload"),
            )
          ],
          elevation: 5,
        );
      },
    );
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  backFunction(
      BuildContext context, AsyncSnapshot<WebViewController> controller) async {
    if (controller.data.canGoBack() != null) {
      await che();
      if (connectionStatus == true) {
        controller.data.goBack();
      } else {
        alertDialogBack(context, controller);
      }
    }
  }

  alertDialog(BuildContext context, AsyncSnapshot<WebViewController> controller,
      String loadUrl) {
    // This is the ok button
    // show the alert dialog
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          // title: Text(""),
          content: Text("Check Your Internet Connection"),
          actions: [
            FlatButton(
              onPressed: () async {
                // var currentURL = controller.data.currentUrl();
                await che();
                if (connectionStatus == true) {
                  controller.data.loadUrl(loadUrl);
                }
                Navigator.of(context).pop();
              },
              child: Text("Reload"),
            )
          ],
          elevation: 5,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    fun();
    if (check == true) {
      return Container(
        child: Text(" "),
      );
    } else {
      return FutureBuilder(
          future: che(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (connectionStatus == true) {
              return FutureBuilder<WebViewController>(
                  future: _controller.future,
                  builder: (BuildContext context,
                      AsyncSnapshot<WebViewController> controller) {
                    return SafeArea(
                      child: WillPopScope(
                        onWillPop: () => backFunction(context, controller),
                        child: Stack(children: <Widget>[
                          Scaffold(
                            bottomNavigationBar: BottomAppBar(
                              elevation: 0.0,
                              child: ButtonBar(
                                alignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.flash_on),
                                      iconSize: 29,
                                      onPressed: () {
                                        if (connectionStatus == true) {
                                          controller.data.loadUrl(
                                              "https://www.gotestseries.com/index.php");
                                        } else {
                                          alertDialog(context, controller,
                                              "https://www.gotestseries.com/index.php");
                                        }
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.local_library),
                                      iconSize: 29,
                                      onPressed: () {
                                        if (connectionStatus == true) {
                                          controller.data.loadUrl(
                                              "https://www.gotestseries.com/tests.php");
                                        } else {
                                          alertDialog(context, controller,
                                              "https://www.gotestseries.com/tests.php");
                                        }
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.search),
                                      iconSize: 29,
                                      onPressed: () {
                                        if (connectionStatus == true) {
                                          controller.data.loadUrl(
                                              "https://www.gotestseries.com/search.php");
                                        } else {
                                          alertDialog(context, controller,
                                              "https://www.gotestseries.com/search.php");
                                        }
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.insert_chart),
                                      iconSize: 29,
                                      onPressed: () {
                                        if (connectionStatus == true) {
                                          controller.data.loadUrl(
                                              "https://www.gotestseries.com/results.php");
                                        } else {
                                          alertDialog(context, controller,
                                              "https://www.gotestseries.com/results.php");
                                        }
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.person),
                                      iconSize: 29,
                                      onPressed: () {
                                        if (connectionStatus == true) {
                                          controller.data.loadUrl(
                                              "https://www.gotestseries.com/profile.php");
                                        } else {
                                          alertDialog(context, controller,
                                              "https://www.gotestseries.com/profile.php");
                                        }
                                      }),
                                ],
                              ),
                            ),
                            backgroundColor: Colors.white,
                            body: Stack(children: <Widget>[
                              WebView(
                                initialUrl: url,
                                javascriptMode: JavascriptMode.unrestricted,
                                onWebViewCreated:
                                    (WebViewController webViewController) {
                                  _controller.complete(webViewController);
                                },
                                onPageFinished: (_) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                gestureNavigationEnabled: true,
                                navigationDelegate:
                                    (NavigationRequest request) {
                                  if (connectionStatus == true) {
                                    if (!(request.url.startsWith("http:") ||
                                        request.url.startsWith("https:"))) {
                                      _launchURL(request.url);
                                      return NavigationDecision.prevent;
                                    }
                                    return NavigationDecision.navigate;
                                  } else {
                                    alertDialog(
                                        context, controller, request.url);
                                    return NavigationDecision.prevent;
                                  }
                                },
                              ),
                            ]),
                          ),
                          isLoading ? Center( child: Image.asset('asset/logo.jpg')) : Container(),
                        ]),
                      ),
                      top: true,
                    );
                  });
            } else {
              return Container(
                constraints: new BoxConstraints.expand(
                  height: 200.0,
                ),
                alignment: Alignment.bottomLeft,
                padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('asset/logo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: ((MediaQuery.of(context).size.height) / 2),
                    ),
                    SizedBox(
                      height: ((MediaQuery.of(context).size.height) / 4),
                    ),
                    Align(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text('Check Your Internet Connection',
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 13.0,
                            )),
                      ),
                    ),
                  ],
                ),
              );
            }
          });
    }
  }
}

Future che() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connectionStatus = true;
      print("connected $connectionStatus");
    }
  } on SocketException catch (_) {
    connectionStatus = false;
    print("not connected $connectionStatus");
  }
}

Future<void> _updateConnection(ConnectivityResult result) async {
  if (result == ConnectivityResult.none) {
    connectionStatus = false;
  }
}
