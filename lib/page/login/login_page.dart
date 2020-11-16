
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrationTextApp/common/login/loadingDialog.dart';
import 'package:integrationTextApp/resource/base_resp.dart';
import 'package:integrationTextApp/view_modules/login/login_module.dart';
import 'package:toast/toast.dart';

import '../sheetpageroute_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _FocusTestRouteState createState() => new _FocusTestRouteState();
}

class _FocusTestRouteState extends State<LoginPage> {
  Response response;
  FocusNode userName = new FocusNode();
  FocusNode passWord = new FocusNode();
  FocusScopeNode focusScopeNode;
  TextEditingController controllerUserName = new TextEditingController(text: "17621763856");
  TextEditingController controllerPassWord = new TextEditingController(text: "123456a");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 200),
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 300,
              maxHeight: 100,
            ),
            //用户名
            child: TextField(
              controller: controllerUserName,
              textInputAction: TextInputAction.next,
              autofocus: true,
              focusNode: userName,
              decoration: InputDecoration(
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x00FF0000)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x00000000)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 300,
              maxHeight: 100,
            ),
            //密码
            child: TextField(
              // obscureText: true,
              textInputAction: TextInputAction.done,
              controller: controllerPassWord,
              focusNode: passWord,
              maxLength: 8,
              maxLengthEnforced: false,
              autofocus: true,
              //隐藏密码变成星星
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x00FF0000)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x00000000)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.lock),
                labelText: "密码",
                // fillColor: Colors.blue,
                hintText: "请输入密码",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  child: Text("登录"),
                  color: Colors.blue,
                  onPressed: () async {
                    //点击确认之后清空
                    userName.unfocus();
                    passWord.unfocus();
                    //    print(controllerUserName.text + "-----------" + controllerPassWord.text);
                    //等待效果
                    Navigator.push(context, DialogRouter(LoadingDialog(true)));
                    //发送接口请求
                    BaseResp data = await LoginVM().requestLogin(controllerUserName.text, controllerPassWord.text, context);
                    Navigator.pop(context);
                    if (data.result) {
                      //登录成功跳转页面
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SheetPageRoute();
                        //  return RouteList();
                      }));
                    } else {
                      //不成功内容提示
                      Toast.show(data.msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    }
                    //点击弹出等待窗
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    //   return LoadingDialog(true);
                    // }));
                  }),
              Padding(padding: EdgeInsets.all(10)),
              RaisedButton(
                  child: Text("取消"),
                  color: Colors.blue,
                  onPressed: () {
                    controllerUserName.clear();
                    controllerPassWord.clear();
                    userName.unfocus();
                    passWord.unfocus();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
