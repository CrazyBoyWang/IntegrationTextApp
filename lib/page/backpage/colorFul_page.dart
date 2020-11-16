import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text("吃饭饭，睡觉觉"),
      // ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeOrange,
          child: Text("Press"),
          onPressed: () {
            showDialog(context: context, builder:(BuildContext context) {
              return SimpleDialog(
                children: [
                  Text("Hello world"),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
