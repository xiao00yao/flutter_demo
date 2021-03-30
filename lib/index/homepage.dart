import 'package:flutter/material.dart';

///首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/2.0x/index_bg.png",
                height: 160,
                width: double.infinity,
              ),
              Positioned(
                  child: Container(
                alignment: Alignment.center,
                width: 290,
                height: 30,
                margin: EdgeInsets.only(top: 36),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular((20.0))),
                child: ListView(
                  scrollDirection: Axis.horizontal, //水平布局
                  children: [
                    Image.asset(
                      "assets/images/2.0x/index_search_image.png",
                      height: 14,
                      width: 14,
                    ),
                    Text(
                      "输入楼盘名称/街道号/房源编号/业主手机号以查找",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
