import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AutoPlatformPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<AutoPlatformPage> {
  WebViewController _controller;
  String _title = "webView";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("$_title"),
      ),
      child: SafeArea(
        child: WebView(
          initialUrl: "https://www.baidu.com",
          //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onWebResourceError: (WebResourceError error) {
            print(error.description);
          },
          onPageFinished: (url) {
            _controller.evaluateJavascript("document.title").then((result) {
              setState(() {
                _title = result;
              });
            });
          },
          // navigationDelegate: (NavigationRequest request) {
          //   if (request.url.startsWith("myapp://")) {
          //     print("即将打开 ${request.url}");
          //
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
          // javascriptChannels: <JavascriptChannel>[
          //   JavascriptChannel(
          //       name: "share",
          //       onMessageReceived: (JavascriptMessage message) {
          //         print("参数： ${message.message}");
          //       }),
          // ].toSet(),
        ),
      ),
    );
  }
}
