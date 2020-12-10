import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrationTextApp/main_setting/main_mixin.dart';
import 'package:integrationTextApp/page/backpage/ListView_page.dart';
import 'package:integrationTextApp/page/backpage/ToDoList.dart';
import 'package:integrationTextApp/page/backpage/colorFul_page.dart';
import 'package:integrationTextApp/page/login/login_page.dart';

void main() {
  /*

  初次调用  pumpWidget()  之后， WidgetTester  会提供其他方式来重建相同的 widget。 这对使用  StatefulWidget  或者动画会非常有用。
  例如，如果我们点击调用 setState() 的按钮，在测试环境中，Flutter 并不会自动重建你的 widget。我们需要用以下列举的方法来让 Flutter 再一次建立我们的 widget。

  在给定时间内重建widget
    await tester.pump();

  在给定期间内不断重复调用 pump 直到完成所有绘制帧。一般需要等到所有动画全部完成。
    await tester.pumpAndSettle();



  使用 Matcher 验证 widget 是否正常工作

  最后，让我们来用 flutter_test 提供的 Matcher 常量验证 Text widgets 显示的标题和信息。Matcher 类是 test 包里的核心部分，它提供一种通用方法来验证给定值是否符合我们的预期。

  在这个示例中，我们要确保 Widget 只在屏幕中出现一次。因此，可以使用 findsOneWidget Matcher。
  除了 findsOneWidget，flutter_test 还为常见情况提供了其他的 matchers。

  findsNothing验证没有可被查找的 widgets。

  findsWidgets验证一个或多个 widgets 被找到。

  findsNWidgets验证特定数量的 widgets 被找到。

   */
  testWidgets('登录的测试', (WidgetTester tester) async {
//    await tester.pump();
    Widget  body1  = LoginPage();
    List widgets = [body1];

    for(Widget body in widgets) {
      MaterialApp app = MaterialApp(
        home: Scaffold(
          body: body,
        ),
      );
      print("111");
      await tester.pumpWidget(app);
    }

    // await tester.tap(find.text('登录'));
   // expect(find.text("登录"), findsOneWidget);

    //   expect(titleFinder, findsOneWidget);

    //  expect(find.text("密码"), findsNothing);

    //   await tester.tap(find.byIcon(Icons.person));
    //   await tester.pump();

//    await tester.tap(find.byKey(a));
  } , variant: TargetPlatformVariant.only(TargetPlatform.iOS));
}

