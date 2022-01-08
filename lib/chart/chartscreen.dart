import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChartScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const ChartScreen({Key? key, required this.data}) : super(key: key);
  static const routename = '/chartscreen';

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen>
    with AutomaticKeepAliveClientMixin {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body:
            // Container(
            // height: MediaQuery.of(context).size.height,
            // child: Column(
            //   children: [
            //     Flexible(
            //         child:
            WebView(
      backgroundColor: Color(0xff17173D),
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: '',
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
        _loadHtmlFromAssets();
      },
      onPageStarted: (url) {
        _controller.runJavascript("var symbol = '${widget.data['pair']}'");
      },
    ));
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/index.html');
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
