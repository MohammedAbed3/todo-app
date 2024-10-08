import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Webview extends StatelessWidget {

  final String url;

  const Webview(this.url, {super.key});

  @override
  Widget build(BuildContext context) {


    WebViewController controller =WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url.toString()));
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: controller,

      ),
    );
  }
}
