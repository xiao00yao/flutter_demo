import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/house/houserentpage.dart';
import 'package:flutter_demo/house/housesalepage.dart';
import 'package:flutter_demo/utils/andutils.dart';

/// 房源界面
class HousePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HouseState();
  }
}

class HouseState extends State<HousePage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    TabController mTabController = TabController(length: 2,vsync: this);
    PageController mPageController = PageController();
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(left: 15, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          AndUtils.image + "search.png",
                          width: 13,
                          height: 13,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "输入楼盘名称/街道号/房源编号/业主手机号",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  )),
                  Container(
                    width: 50,
                    height: 45,
                    padding: EdgeInsets.all(15),
                    child: Image.asset(
                      AndUtils.image + "add.png",
                      width: 17,
                      height: 17,
                    ),
                  )
                ],
              ),
              Container(
                height: 30,
                width: double.infinity,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Color(0xFF3EBA70),
                  labelColor: Color(0xFF3EBA70),
                  unselectedLabelColor: Colors.black,
                  tabs: <Text>[
                    Text("二手房"),
                    Text("出租房"),
                  ],
                  controller: mTabController,
                  onTap: (index){
                    mPageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
                  },
                ),
              ),
              Expanded(
                child: PageView(
                  controller: mPageController,
                  children: [HouseSalePage(), HouseRentPage()],
                  onPageChanged: (index){
                    mTabController.animateTo(index);
                  },
                ),
              )
            ],
          )),
    );
  }
}
