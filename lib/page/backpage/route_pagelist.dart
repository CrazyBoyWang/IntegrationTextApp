//二级页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrationTextApp/page/backpage/random_page.dart';

import 'ClipTestRoute.dart';
import 'colorFul_page.dart';

class RouteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("路由进入页面"),
      ),
      body: Center(
          child: Column(
        //    crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: FlatButton(
              child: Text("点击进入新页面"),
              textColor: Colors.blue,
              //回调代码
              onPressed: () {
                //导航到新路由
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   bool maintainState = true;
                //   bool fullscreenDialog = false;
                //
                //   return RouterTestRoute();
                // }));
                Navigator.pushNamed(context, "RouterTestRoute");
              },
            ),
          ),
          Align(
            //增加一个logo
            widthFactor: 2,
            heightFactor: 2,
            alignment: Alignment.bottomLeft,
            child: FlutterLogo(
              size: 60,
            ),
          ),
          Row(
            children: [
              Text('点，给老子点'),
              SizedBox(
                width: 10,
              ),
              Text('点，给老子点33'),
            ],
          ),
          RandomWordsWidget(),
          CupertinoTestRoute(),
          ClipTestRoute(),

          SizedBox(
            width: 50,
            height: 50,
          ),
          //翻转按钮
          Container(
            color: Colors.black,
            child: new Transform(
              alignment: Alignment.topLeft,
              transform: new Matrix4.skew(0, 7),
              child: new Container(
                width: 100,
                padding: const EdgeInsets.only(bottom: 10),
                color: Colors.deepOrange,
                child: const Text('data'),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
