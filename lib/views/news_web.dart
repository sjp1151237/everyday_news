import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsWeb extends StatefulWidget {

  final String webUrl;
  final String mTitle;

  const NewsWeb({Key key, this.webUrl, this.mTitle}) : super(key: key);

  @override
  _NewsWebState createState() => _NewsWebState();
}

class _NewsWebState extends State<NewsWeb> {

  String url;
  String mTitle;
  @override
  void initState() {
    super.initState();
    url = this.widget.webUrl;
    mTitle = this.widget.mTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mTitle),
      ),
      body: WebviewScaffold(
        url: url,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
      ),
    );
  }
}
