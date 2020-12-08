//主页面底部tabbar
//import 'package:app_ftr/pages/DyPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:integrationTextApp/page/setclass/setclass_page.dart';

//动态组件
class SheetPageRoute extends StatefulWidget {
  SheetPageRoute({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<SheetPageRoute> {
  //初始化控制器
  PageController _pageController = PageController();
  int _currentIndex = 0; //底部tap高亮下标

  void initState() {
    super.initState();
    //监听控制器滑动变化,改变底部tap
    _pageController.addListener(() {
      setState(() {
        _currentIndex = (_pageController.page).round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: false);
    return Scaffold(
      body: _currentPage(),
      //底部导航Bar
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
            //控制器跳转页面
            _pageController.jumpToPage(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          items: [BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('建课')),
            BottomNavigationBarItem(icon: Icon(Icons.settings_system_daydream_rounded), title: Text('天气')),
            BottomNavigationBarItem(icon: Icon(Icons.ramen_dining), title: Text('你猜')),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), title: Text('我的'))]),
    );
  }

  //底部对应 页面
  Widget _currentPage() {
    List _pages = [
      SetClassPageRoute(), //下面可自定义页面组件
      Text('图书'),
      Text('个人'),
      Text('emmmm'),
    ];

    return PageView.builder(
        // physics: NeverScrollableScrollPhysics(), //禁用左右滑动
        itemCount: _pages.length,
        controller: _pageController, //控制器
        itemBuilder: (context, index) => _pages[index] //构建一个页面实例
        );
  }
}
