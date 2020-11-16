import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'InfiniteListView_page.dart';

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text, // 接收一个text参数
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第三层界面"),
        actions: <Widget>[

        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 200),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("返回"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("EchoPage");
                },
                child: Text("点击报错。关于传参",
                  textAlign: TextAlign.center,
                ),
                textColor: Colors.indigo,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
