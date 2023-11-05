import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticleView extends StatefulWidget {
  String blogUrl;
 ArticleView({required this.blogUrl});
  @override
  State<ArticleView> createState() => _ArticleViewState();
}
class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Samachar",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
              Text(
                "App",
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold, fontSize: 24
                ),
              )
            ],
          ),
          elevation: 0,
        ),
        body:Container(
      child: WebView(
        initialUrl: widget.blogUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
        ) );
  }
}
