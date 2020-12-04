import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoScreenTitle extends StatelessWidget {
//  @override
//  _AutoScreenTitle createState() => _AutoScreenTitle();

  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
//    ScreenUtil.init(context, designSize: Size(750,Ω 1334), allowFontScaling: false);
    return MaterialApp(
      title: "适配页面",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text("头"), Text("低")],
          ),
        ),
      ),
    );

    //默认 width : 1080px , height:1920px , allowFontScaling:false
  }
}

//
// class _AutoScreenTitle extends State<AutoScreenTitle> {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//         builder: (context, constraints){
//           ScreenUtil.init(constraints,designSize: Size(750, 1334),allowFontScaling: false);
//           return MaterialPage(child: );
//
//         }
//
//
//
//
//
//
//
//     );
//
//
//
//
//   }
// }
