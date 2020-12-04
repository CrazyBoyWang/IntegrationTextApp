import 'package:flutter/material.dart';
import 'backpage/RouterTestRoute.dart';
import 'backpage/echo_page.dart';
import 'login/login_page.dart';

class RouterNames {
  static String root = "/";
  static String echo = "EchoPage";
  static String login = "RouterTestRoute";

  static Widget choosePage(String name) {
    if (RouterNames.root == name) {
      return MyHomePage(
        title: "登录界面",
      );
    } else if (RouterNames.echo == name) {
      bool isLogin = true;
      if (!isLogin) return Container();
      return EchoPage();
    } else if (RouterNames.login == name) {
      return RouterTestRoute();
    } else {
      return Container();
    }
  }
}

// ignore: must_be_immutable
class StartApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<StartApp> {
  @override
  Widget build(BuildContext context) {
   // ScreenUtil.init(context,);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //路由生成钩子
      //注意，onGenerateRoute只会对命名路由生效。
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return RouterNames.choosePage(settings.name);
        });
      },
      //注册路由表
      // routes: {
      //   "new page": (context) => Route(),
      //   "/": (context) => MyHomePage(title: "Flutter Demo Home Page"),
      //   "RouterTestRoute": (context) => RouterTestRoute(),
      //   "EchoPage": (context) => EchoPage(),
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//主页面
class _MyHomePageState extends State<MyHomePage> {
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          //' mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //  TextFieldTest(),

            //登录信息
        //    AutoScreenTitle(),
            LoginPage(),

          ],
        ),

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
