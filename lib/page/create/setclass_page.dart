import 'package:flutter/material.dart';
import 'package:integrationTextApp/common/create/proptities.dart';
import 'package:integrationTextApp/resource/base_resp.dart';
import 'package:integrationTextApp/view_modules/create/setclass_module.dart';
import 'package:toast/toast.dart';

class SetClassPageRoute extends StatefulWidget {
  @override
  _SetClassPage createState() => _SetClassPage();
}

class _SetClassPage extends State<SetClassPageRoute> {
  TextEditingController classLessonName = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //调用AR登录接口
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("AR登录"),
                onPressed: () async {
                  BaseResp arLoginResult = await SetClass().requestARLogin(Parameter.arUserName, Parameter.arPassWord);
                  //判断登录是否成功并给出结论
                  if (arLoginResult.code == 10000) {
                    Toast.show("登录成功请继续操作", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  }
                  //        print(arLoginResult.data);
                  Map userInfO = arLoginResult.data["userInfoVO"];
                  //获取token并存到配置文件中
                  Parameter.token = userInfO["token"];
                  print(Parameter.token);
                },
              ),
            ],
          ),
          //添加课时
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("添加课时"),
                onPressed: () async {
                  //判断输入课时名称内容不能为空
                  //          print(classLessonName.text);
                  if (classLessonName.text != "" && classLessonName.text != " ") {
                    //判断是否token
                    if (Parameter.token != "") {
                      BaseResp addLesson = await SetClass().requestAddLesson(classLessonName.text);
                      print(addLesson);
                    } else {
                      //如果没有则提示需要点击登录存储token
                      Toast.show("请先AR登录获取Token", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    }
                  } else {
                    Toast.show("请输入课时名称", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);

                    print("数据处理失败");
                  }
                },
              ),
              Padding(padding: EdgeInsets.all(5)),
              ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 100,
                  ),
                  child: TextField(
                    controller: classLessonName,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    //       focusNode: userName,
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
                      hintText: "请输入课时名称",
                      //  prefixIcon: Icon(Icons.person)
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
