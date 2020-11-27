import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integrationTextApp/common/setclass/proptities.dart';
import 'package:integrationTextApp/resource/base_resp.dart';
import 'package:integrationTextApp/view_modules/datasource/setclass_db_module.dart';
import 'package:integrationTextApp/view_modules/setclass/setclass_module.dart';

class OnekeySetClass extends StatelessWidget {
  String classLessonName;
  String classCourseName;
  Function callBack;

  var result;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[

          RaisedButton(
              child: Text("一键建课"),
              onPressed: () async {
                classLessonName = WordPair.random().toString();
                //AR登录
                BaseResp arLoginResult = await SetClass().requestARLogin(SetClassParameter.arUserName, SetClassParameter.arPassWord);
                Map userInfO = arLoginResult.data["userInfoVO"];
                //获取token并存到配置文件中
                SetClassParameter.token = userInfO["token"];

                //添加课时
                BaseResp addLesson = await SetClass().requestAddLesson(classLessonName);

                //根据课程名称获取课时id
                BaseResp getLessonId = await DataSourceRequest().requestGetLessonId(classLessonName);

                //发布课时
                BaseResp issueLesson = await SetClass().requestIssueLesson(getLessonId.data["id"]);

                //组建课程
                //现在是主课1V3课程code
                classCourseName = WordPair.random().toString();
                BaseResp addCourses = await SetClass().requestSetUpCourses(classCourseName, classLessonName, getLessonId.data["id"], 10);

                //发布课程
                BaseResp issueCourses = await SetClass().requestIssueCourses(addCourses.data, classCourseName);

                //组建模板
                BaseResp newMould = await SetClass().requestNewMould(getLessonId.data["id"], addCourses.data, classLessonName);
                Future.delayed(Duration(milliseconds: 2000), () async {
                  if (newMould.code == 10000) {
                    BaseResp getCourseIds = await DataSourceRequest().requestGetCourseIds(classCourseName);
                 //   print(getCourseIds);
                    if (getCourseIds.data != null) {
                      //上架班级
                      BaseResp groundClass = await SetClass().requestGroundClass(getCourseIds.data["id"]);
                 //     print(groundClass);
                      if (groundClass.code == 10000) {
                        var result = "课时名称:"+classLessonName + ",建课名称:" + classCourseName;
                      print(result);
                        callBack(result);
                      }
                    }
                  }
                });
              }),
          // Row(
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.all(10),
          //       child: Text("$result"),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
