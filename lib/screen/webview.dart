import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:newsapp/model/webview_model.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

class webview extends StatefulWidget {
  final String url;
  const webview({super.key, required this.url});

  @override
  State<webview> createState() => _webviewState();
}

class _webviewState extends State<webview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "News",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                "Center",
                style: TextStyle(color: Colors.teal, fontSize: 30),
              )
            ],
          ),
        ),
        //centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<bool>(
        future: checkInternetConnection(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // The Future is still running, show a loading indicator
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              // There was an error, handle it accordingly
              return Text('Error: ${snapshot.error}');
            } else {
              // Check the internet connection status
              bool isConnected = snapshot.data ?? false;

              if (isConnected) {
                // Internet connection is available, do something
                return Consumer<webview_model>(
                  builder: (BuildContext context, webview_model value,
                      Widget? child) {
                    return Stack(
                      children: [
                        InAppWebView(
                          initialUrlRequest:
                              URLRequest(url: WebUri("${widget.url}")),
                          onProgressChanged: (InAppWebViewController controller,
                              int progress) {
                            value.changeprogress(progress.toDouble());
                            // print(progress);
                          },
                        ),
                        value.progress < 100
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox()
                      ],
                    );
                  },
                );
              } else {
                // No internet connection, display a message or take appropriate action
                return Center(child: Text('No internet connection'));
              }
            }
          }
        },
      ),
    );
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    return false; // No internet connection
  } else {
    return true; // Internet connection is available
  }
}
