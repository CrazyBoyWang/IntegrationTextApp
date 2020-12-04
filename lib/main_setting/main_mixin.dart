import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrationTextApp/main_setting/setting_mixin.dart';
import 'package:integrationTextApp/page/home_page.dart';
import 'package:integrationTextApp/page/login/login_page.dart';

/// 启动应用
void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSystemInfo();

  FlutterError.onError = (FlutterErrorDetails e) {
    Zone.current.handleUncaughtError(e.exceptionAsString(), e.stack);
  };
  runZonedGuarded<Future<Null>>(() async {
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    print(error);
  });
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context,);
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: MyHomePage(title: "Home",),
      ),
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

/// 获取全局的context
BuildContext getNavigatorContext() {
  return navigatorKey.currentState.overlay.context;
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

