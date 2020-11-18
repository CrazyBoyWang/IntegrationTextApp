import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:integrationTextApp/common/setclass/proptities.dart';
import 'package:integrationTextApp/view_modules/datasource/setclass_db_module.dart';
import 'package:integrationTextApp/resource/base_resp.dart';
import 'package:integrationTextApp/view_modules/setclass/setclass_module.dart';
import 'package:toast/toast.dart';

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
  List a;

//   List b = ["name", "asdasds", "code", 123];
//
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     // getList();
//   }
//
//   void getList() async {
//     BaseResp courseNameType = await DataSourceRequest().requestGetCourseNameType();
//     List b = courseNameType.data;
//     print(b);
//     setState(() {
//
//     });
//   }

  // List<DropdownMenuItem> getListData(){
  //   List<DropdownMenuItem> items=new List();
  //   DropdownMenuItem dropdownMenuItem1=new DropdownMenuItem(
  //     child:new Text('1'),
  //     value: '1',
  //   );
  //   items.add(dropdownMenuItem1);
  //   DropdownMenuItem dropdownMenuItem2=new DropdownMenuItem(
  //     child:new Text('2'),
  //     value: '2',
  //   );
  //   items.add(dropdownMenuItem2);
  //   DropdownMenuItem dropdownMenuItem3=new DropdownMenuItem(
  //     child:new Text('3'),
  //     value: '3',
  //   );
  //   items.add(dropdownMenuItem3);
  //   DropdownMenuItem dropdownMenuItem4=new DropdownMenuItem(
  //     child:new Text('4'),
  //     value: '4',
  //   );
  //   items.add(dropdownMenuItem4);
  //   DropdownMenuItem dropdownMenuItem5=new DropdownMenuItem(
  //     child:new Text('5'),
  //     value: '5',
  //   );
  //   items.add(dropdownMenuItem5);
  //   DropdownMenuItem dropdownMenuItem6=new DropdownMenuItem(
  //     child:new Text('6'),
  //     value: '6',
  //   );
  //   items.add(dropdownMenuItem6);
  //   DropdownMenuItem dropdownMenuItem7=new DropdownMenuItem(
  //     child:new Text('7'),
  //     value: '7',
  //   );
  //   items.add(dropdownMenuItem7);
  //   DropdownMenuItem dropdownMenuItem8=new DropdownMenuItem(
  //     child:new Text('8'),
  //     value: '8',
  //   );
  //   items.add(dropdownMenuItem8);
  //   DropdownMenuItem dropdownMenuItem9=new DropdownMenuItem(
  //     child:new Text('9'),
  //     value: '9',
  //   );
  //   items.add(dropdownMenuItem9);
  //   DropdownMenuItem dropdownMenuItem10=new DropdownMenuItem(
  //     child:new Text('10'),
  //     value: '10',
  //   );
  //   items.add(dropdownMenuItem10);
  //   return items;
  // }
  //
  // var value;

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
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("发布课时"),
                onPressed: () async {
                  //调用自动化平台接口获取课时id
                  BaseResp getLessonId = await DataSourceRequest().requestGetLessonId(classLessonName.text);
                  print(getLessonId);
                  print(getLessonId.data["id"]);
                  // List list = getLessonId.data;
                  // print(list.first['id']);
                  SetClassParameter.lessonId = getLessonId.data["id"];
                  //   int lessionId
                  BaseResp issureLesson = await SetClass().requestIssureLesson(SetClassParameter.lessonId);
                  //判断登录是否成功并给出结论
                  if (issureLesson.code == 10000) {
                    Toast.show("发布成功，请继续操作", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  }
                  //        print(arLoginResult.data);
                  // Map userInfO = issureLesson.data["userInfoVO"];
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
                    if (classCourseName.text != "" && classLessonName.text !="") {
                      BaseResp courseNameType = await DataSourceRequest().requestGetCourseNameType();
                      a = courseNameType.data;
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 1000,
                              child: ListView(
                                children: a.map((e) {
                                  return ListTile(
                                    leading: Icon(Icons.settings),
                                    title: Text(e["name"]),
                                    onTap: () async {
                                      resCode = e["code"];
                                      print(e["code"]);
                                      Navigator.pop(context);
                                      lessonName.unfocus();
                                      if (resCode != null) {
                                        BaseResp addLesson = await SetClass().requestSetUpCourses(classCourseName.text, classLessonName.text, SetClassParameter.lessonId, resCode);
                                        print(addLesson);
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
              //      Padding(padding: EdgeInsets.all(5)),

//               new DropdownButton(
//                 items: getListData(),
//                 hint:new Text('下拉选择你想要的数据'),//当没有默认值的时候可以设置的提示
//                 value: value,//下拉菜单选择完之后显示给用户的值
//                 onChanged: (T){//下拉菜单item点击之后的回调
//                   setState(() {
//                     value=T;
//                   });
//                 },
//                 elevation: 24,//设置阴影的高度
//                 style: new TextStyle(//设置文本框里面文字的样式
//                     color: Colors.red
//                 ),
// //              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
//                 iconSize: 50.0,//设置三角标icon的大小
//               ),
//               // DropdownButton(
//               // value: _value, style: ,
//               // icon: Icon(Icons.arrow_right), iconSize: 40, iconEnabledColor: Colors.green.withOpacity(0.7),
//               // hint: Text('请选择地区'), isExpanded: true, underline: Container(height: 1, color: Colors.green.withOpacity(0.7)),
//               // items: [
//               // DropdownMenuItem(
//               // child: Row(children: <Widget>[Text('北京'), SizedBox(width: 10), Icon(Icons.ac_unit) ]),
//               // value: 1),
//               // DropdownMenuItem(
//               // child: Row(children: <Widget>[Text('天津'), SizedBox(width: 10), Icon(Icons.content_paste) ]),
//               // value: 2),
//               // DropdownMenuItem(
//               // child: Row(children: <Widget>[Text('河北', style: TextStyle(color: Colors.purpleAccent, fontSize: 16)), SizedBox(width: 10), Icon(Icons.send, color: Colors.purpleAccent) ]),
//               // value: 3)
//               // ],
//               // onChanged: (value) => setState(() => _value = value));
//               //
//               //

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
        ],
      ),
    );
  }
}
