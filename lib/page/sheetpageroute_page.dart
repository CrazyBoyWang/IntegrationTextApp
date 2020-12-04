import 'package:flutter/material.dart';
import 'setclass/setclass_page.dart';

class SheetPageRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<SheetPageRoute> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: pages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return buildBottomTabScaffold();
  }

  int currentIndex = 0;
  //控制页面跳转信息
  final pages = [SetClassPageRoute(), ChildItemView("发现"), ChildItemView("我的")];

  Widget buildBottomTabScaffold() {
    return new Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("App Name"),
      body: new TabBarView(controller: _tabController, children: pages),
      bottomNavigationBar: new Material(
        color: Colors.indigo,
        child: new TabBar(
          controller: _tabController,
          tabs: <Tab>[
            new Tab(icon: new Icon(Icons.home),
              child: Text("建课",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 12,
                  color: Color(0xFF999999),
              //    fontFamily: TextStyles.fzfontFamily,
                ),
              ),





            ),
            new Tab(icon: new Icon(Icons.find_in_page),
              child: Text("发现",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 12,
                color: Color(0xFF999999),
                //    fontFamily: TextStyles.fzfontFamily,
              ),
            ),







            ),
            new Tab(icon: new Icon(Icons.person),
              child: Text("我的",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 12,
                  color: Color(0xFF999999),
                  //    fontFamily: TextStyles.fzfontFamily,
                ),
              ),








            ),
          ],
          indicatorWeight: 0.1,
        ),
      ),
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
// body: Center(
//   //创建Class信息
//   child: SetClassPageRoute(),
// ),
//
// bottomNavigationBar: BottomAppBar(
//   color: Colors.white,
//   shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
//   child: Row(
//     children: <Widget>[
//       IconButton(
//         icon: Icon(Icons.home),
//         onPressed: () {},
//       ),
//       SizedBox(), //中间位置空出
//       IconButton(
//         icon: Icon(Icons.business),
//         onPressed: () {},
//       ),
//     ],
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //均分底部导航栏横向空间
//   ),
// ),
// //挪移到中间位置
// floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
// );
}

//子页面
class ChildItemView extends StatefulWidget {
  String _title;
  ChildItemView(this._title);


  @override
  _ChildItemViewState createState() => _ChildItemViewState();
}

class _ChildItemViewState extends State<ChildItemView> {

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child:Text("敬请期待")));
  }
}
