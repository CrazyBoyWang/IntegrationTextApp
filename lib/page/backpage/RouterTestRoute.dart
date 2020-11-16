import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrationTextApp/page/backpage/back_page.dart';
import 'package:integrationTextApp/page/sheetpageroute_page.dart';
import 'package:integrationTextApp/page/backpage/switch.dart';

import 'InfiniteListView_page.dart';
import 'ListView_page.dart';
import 'SingleChildScrollViewTesRoute_page.dart';
import 'flow_page.dart';

class RouterTestRoute extends StatelessWidget {
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("第二层"),
      ),
      body: Row(
        children: [
          Expanded(

            child: RaisedButton.icon(
              //添加按钮央视
              icon: Icon(Icons.send),

              onPressed: () async {
                //打开TipRoute，并风带返回结果
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TipRoute(
                        //路由参数
                        text: "吃饭睡觉打豆豆",
                      );
                    },
                  ),
                );
                print("路由返回值： $result");
              },
              label: Text(
                "走你",
              ),
              splashColor: Colors.red,
            ),
          ),
          Expanded(
              //插入图片
              //padding: EdgeInsets.all(300),
              child: Image(
                alignment: Alignment.center,
                image: AssetImage("assets/images/1.png"),
                width: 200,
                height: 200,
              )),
          //单选复选框
          SwitchAndCheckBoxTestRoute(),
          SingleChildScrollViewTestRoute(),




        ],
      ),
    );
  }
}
