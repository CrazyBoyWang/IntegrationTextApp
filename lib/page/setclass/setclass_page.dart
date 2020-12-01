import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:integrationTextApp/common/base-api-provider.dart';
import 'package:integrationTextApp/common/setclass/proptities.dart';
import 'package:integrationTextApp/view_modules/datasource/setclass_db_module.dart';
import 'package:integrationTextApp/resource/base_resp.dart';
import 'package:integrationTextApp/view_modules/setclass/setclass_module.dart';
import 'package:toast/toast.dart';

import 'onekeysetclass_page.dart';

class SetClassPageRoute extends StatefulWidget {
  @override
  _SetClassPage createState() => _SetClassPage();
}

class _SetClassPage extends State<SetClassPageRoute> {
  TextEditingController classLessonName = new TextEditingController();
  TextEditingController classCourseName = new TextEditingController();
  FocusNode lessonName = new FocusNode();
  FocusNode courseName = new FocusNode();
  int resCode;
  List classList;
  var result;
  var createOrderId;

  @override
  Widget build(BuildContext context) {
    OnekeySetClass onekeySetClass = OnekeySetClass();
    onekeySetClass.callBack = (value) {
      print(value);
      setState(() {
        result = value;
      });
    };
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
                    //     textInputAction: TextInputAction.,
                    autofocus: false,
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

          //发布课时
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("发布课时"),
                onPressed: () async {
                  //调用自动化平台接口获取课时id
                  BaseResp getLessonId = await DataSourceRequest().requestGetLessonId(classLessonName.text);
                  print(getLessonId.code);
                  print(getLessonId.data["id"]);
                  // List list = getLessonId.data;
                  // print(list.first['id']);
                  SetClassParameter.lessonId = getLessonId.data["id"];
                  //   int lessionId
                  BaseResp issueLesson = await SetClass().requestIssueLesson(SetClassParameter.lessonId);
                  print(issueLesson);
                  //判断登录是否成功并给出结论
                  if (issueLesson.code == 10000 && getLessonId.data["id"] != null) {
                    Toast.show("发布成功，请继续操作", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  } else {
                    Toast.show("系统异常", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  }
                  //        print(arLoginResult.data);
                  // Map userInfO = issueLesson.data["userInfoVO"];
                  // //获取token并存到配置文件中
                  // SetClassParameter.token = userInfO["token"];
                },
              ),
            ],
          ),

          //组建课程
          Row(
            children: <Widget>[
              RaisedButton(
                  child: Text("组建课程"),
                  onPressed: () async {
                    courseName.unfocus();
                    if (classCourseName.text != "" && classLessonName.text != "") {
                      BaseResp courseNameType = await DataSourceRequest().requestGetCourseNameType();
                      classList = courseNameType.data;

                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 500,
                              child: ListView(
                                children: classList.map((e) {
                                  return ListTile(
                                    leading: Icon(Icons.api_rounded),
                                    title: Text(e["name"]),
                                    onTap: () async {
                                      courseName.unfocus();
                                      resCode = e["code"];
                                      print(e["code"]);
                                      Navigator.pop(context);
                                      lessonName.unfocus();

                                      if (resCode != null) {
                                        BaseResp addCourses = await SetClass().requestSetUpCourses(classCourseName.text, classLessonName.text, SetClassParameter.lessonId, resCode);
                                        print(addCourses);

                                        if (addCourses.code == 10000) {
                                          Toast.show("成功请继续操作", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                                          SetClassParameter.coursesId = addCourses.data;
                                        }
                                        print(addCourses.data);
                                        // 暂时不清空
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            );
                          });
                    } else {
                      Toast.show("请输入建课或课时名称", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                    }
                  }),

              Padding(padding: EdgeInsets.all(5)),
              ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 100,
                  ),
                  child: TextField(
                    controller: classCourseName,
                    //     textInputAction: TextInputAction.next,
                    autofocus: false,
                    focusNode: courseName,
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
                      hintText: "请输入建课名称",
                      //  prefixIcon: Icon(Icons.person)
                    ),
                  )),
            ],
          ),

          //发布课程
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("发布课程"),
                onPressed: () async {
                  //点击进行发布课程
                  BaseResp issueCourses = await SetClass().requestIssueCourses(SetClassParameter.coursesId, classCourseName.text);
                  print(issueCourses);

                  if (issueCourses.code == 10000) {
                    Toast.show("发布成功，请继续操作", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  } else {
                    Toast.show("系统异常", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  }
                  //        print(arLoginResult.data);
                  // Map userInfO = issureLesson.data["userInfoVO"];
                  // //获取token并存到配置文件中
                  // SetClassParameter.token = userInfO["token"];
                },
              ),
            ],
          ),

          //新增模板
          Row(
            children: <Widget>[
              RaisedButton(
                  child: Text("新增模板"),
                  onPressed: () async {
                    // ignore: unrelated_type_equality_checks
                    if (SetClassParameter.lessonId != "" && SetClassParameter.coursesId != "" && classLessonName.text != "") {
                      BaseResp newMould = await SetClass().requestNewMould(SetClassParameter.lessonId, SetClassParameter.coursesId, classLessonName.text);

                      if (newMould.code == 10000) {
                        Toast.show("模板成功并发布，请继续操作", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                        print(newMould);
                        SetClassParameter.issueId = newMould.data;
                      } else {
                        Toast.show("请检查操作", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                      }
                      // ignore: unrelated_type_equality_checks
                    } else if (SetClassParameter.lessonId == "") {
                      Toast.show("课时id为空，请添加个课时吧", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);

                      // ignore: unrelated_type_equality_checks
                    } else if (SetClassParameter.coursesId == "") {
                      Toast.show("课程id为空，请组建个课程吧", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                    } else if (classLessonName.text == "") {
                      Toast.show("没有课时名称？怕不是文本框删除了", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                    }
                  })
            ],
          ),

          //上架班级
          Row(
            children: <Widget>[
              RaisedButton(
                  child: Text("上架班级"),
                  onPressed: () async {
                    //通过自动化平台获取classid和courseid
                    if (classCourseName.text != "") {
                      BaseResp getCourseIds = await DataSourceRequest().requestGetCourseIds(classCourseName.text);
                      print(getCourseIds);
                      //     print(getCourseIds.data["id"]);
                      SetClassParameter.classId = getCourseIds.data["id"];

                      SetClassParameter.classCode = getCourseIds.data["class_code"];
                      BaseResp groundClass = await SetClass().requestGroundClass(SetClassParameter.classId);
                      if (groundClass.code == 10000) {
                        Toast.show("上架班级成功", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      }
                      print(groundClass);
                    } else {
                      Toast.show("建课名称不见了？", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    }

                    if (SetClassParameter.token != null && SetClassParameter.classId != null) {
                      // ignore: unrelated_type_equality_checks
                    } else if (SetClassParameter.classId == "" || SetClassParameter.classId == null) {
                      Toast.show("建课id木有，看看上面操作", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    } else if (SetClassParameter.token == "" || SetClassParameter.token == null) {
                      Toast.show("没token老铁，去登录吧", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    }
                  })
            ],
          ),

          //动态获取建课内容
          Row(
            children: <Widget>[
              onekeySetClass,
              Padding(padding: EdgeInsets.only(left: 50)),
              Text("${result ?? " "}",style: TextStyle(fontSize: 20,color: Colors.red),),
            ],
          ),

          //分割线
          Divider(
            height: 20,
            color: Colors.red,
          ),

          //创建订单
          Row(
            children: <Widget>[
              RaisedButton(
                  child: Text("创建订单"),
                  onPressed: () async {
                    if (SetClassParameter.classId != null && SetClassParameter.classCode != null) {
                      BaseResp createOrder = await SetClass().requestCreateOrder(SetClassParameter.classId, SetClassParameter.classCode);
                      print(createOrder);

                      setState(() {
                        createOrderId = "订单号为:" + createOrder.data;
                      });
                      if (createOrder.code == 10000) {
                        Toast.show("订单获取成功", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      }
                    }
                  }),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 50)),
                  Text("${createOrderId ?? " "}",style: TextStyle(fontSize:20,color: Colors.red,),),
                ],
              )
            ],
          ),
          //刷新获取订单id
        ],
      ),
    );
  }
}
