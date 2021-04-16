import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/house/housepage.dart';
import 'package:flutter_demo/index/customer.dart';
import 'package:flutter_demo/index/homepage.dart';
import 'package:flutter_demo/index/persional.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IndexState();
  }
}

class IndexState extends State<IndexPage> {
  final pages = [HomePage(), HousePage(), CustomerPage(), PersionalPage()];
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/2.0x/main_house_icon.png",
          width: 19,
          height: 19,
        ),
        title: Text("房源")),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/2.0x/main_custom_icon.png",
          width: 19,
          height: 19,
        ),
        title: Text("客源")),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
  ];
  var currenPageIndex = 0; //当前界面下标
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currenPageIndex,
        items: bottomNavItems,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _changePage(index);
        },

      ),
      body: pages[currenPageIndex],
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currenPageIndex) {
      setState(() {
        currenPageIndex = index;
      });
    }
  }

}
