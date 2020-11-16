import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrationTextApp/page/backpage/switch.dart';

class EchoPage extends StatelessWidget {

  // ignore: missing_return

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(top: 200),
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("echo page"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("EchoPage");
              },
              child: Text("点击报错。关于传参"),
            ),

          ],
        ),
      );
    }
}
