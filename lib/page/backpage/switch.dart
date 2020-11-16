import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxTestRoute createState() => new _SwitchAndCheckBoxTestRoute();
}

class _SwitchAndCheckBoxTestRoute extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            }),
        Checkbox(
            value: _checkboxSelected,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value;
              });
            })
      ],
    );
  }
}
