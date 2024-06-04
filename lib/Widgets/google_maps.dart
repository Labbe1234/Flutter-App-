import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleMapEmbed extends StatelessWidget {
  final String apiKey;

  const GoogleMapEmbed({super.key, required this.apiKey});

  @override
  Widget build(BuildContext context) {
    String html = '''
      <!DOCTYPE html>
      <html>
      <head>
        <style>
          html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            overflow: hidden;
          }
        </style>
      </head>
      <body>
        <iframe
          width="100%"
          height="100%"
          frameborder="0" style="border:0"
          src="https://www.google.com/maps/embed/v1/place?key=$apiKey
          &q=Space+Needle,Seattle+WA" allowfullscreen>
        </iframe>
      </body>
      </html>
    ''';

    return Scaffold(
      body: WebView(
        initialUrl: Uri.dataFromString(html, mimeType: 'text/html').toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}