import 'package:flutter/material.dart';
import 'setclass/setclass_page.dart';

class SheetPageRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<SheetPageRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("App Name"),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.accessible_forward_outlined, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: <Widget>[
          RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("back"),
            color: Colors.yellow,
          ),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),

      body: Center(
        //创建Class信息
        child: SetClassPageRoute(),
      ),
      //App Name界面按钮

      // drawer: new Drawer(
      //   child: ListView3(),
      // ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            SizedBox(), //中间位置空出
            IconButton(
              icon: Icon(Icons.business),
              onPressed: () {},
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //均分底部导航栏横向空间
        ),
      ),
      //挪移到中间位置
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
    );
  }
}
