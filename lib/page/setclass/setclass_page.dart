import 'package:flutter/material.dart';
import 'package:integrationTextApp/common/setclass/proptities.dart';
import 'package:integrationTextApp/configs/network_path_config.dart';
import 'package:integrationTextApp/resource/base_resp.dart';
import 'package:integrationTextApp/view_modules/setclass/setclass_module.dart';
import 'package:toast/toast.dart';
import 'package:dio/dio.dart';

class SetClassPageRoute extends StatefulWidget {
  @override
  _SetClassPage createState() => _SetClassPage();
}

class _SetClassPage extends State<SetClassPageRoute> {
  TextEditingController classLessonName = new TextEditingController();
  FocusNode lessonName = new FocusNode();

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
                  BaseResp arLoginResult = await SetClass().requestARLogin(SetClassParameter.arUserName, SetClassParameter.arPassWord);
                  //判断登录是否成功并给出结论
                  if (arLoginResult.code == 10000) {
                    Toast.show("登录成功请继续操作", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  }
                  //        print(arLoginResult.data);
                  Map userInfO = arLoginResult.data["userInfoVO"];
                  //获取token并存到配置文件中
                  SetClassParameter.token = userInfO["token"];
                  print(SetClassParameter.token);
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
                    if (SetClassParameter.token != "") {
                      BaseResp addLesson = await SetClass().requestAddLesson(classLessonName.text);
                      lessonName.unfocus();
                      //暂时不清空
                      // classLessonName.clear();
                      if (addLesson.code == 10000) {
                        Toast.show("操作成功请继续操作", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                      }
                      print(addLesson);
                    } else {
                      //如果没有则提示需要点击登录存储token
                      Toast.show("请先AR登录获取Token", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    }
                  } else {
                    Toast.show("请输入课时名称", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER); // print("数据处理失败");
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
                    focusNode: lessonName,
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
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("发布课时"),
                onPressed: () async {
                  //调用自动化平台接口获取课时id
                  BaseResp getLessonId = await SetClass().requestGetLessonId(classLessonName.text);
                  print(getLessonId);

                  //   int lessionId
                  BaseResp issureLesson = await SetClass().requestIssureLesson(SetClassParameter.lessonId);
                  //判断登录是否成功并给出结论
                  if (issureLesson.code == 10000) {
                    Toast.show("发布成功", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  }
                  //        print(arLoginResult.data);
                  // Map userInfO = issureLesson.data["userInfoVO"];
                  // //获取token并存到配置文件中
                  // SetClassParameter.token = userInfO["token"];
                  print(SetClassParameter.token);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
