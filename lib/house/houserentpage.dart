import 'package:flutter/material.dart';

/**
 * 出租房界面
 */
class HouseRentPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HouseRentState();
  }

}

class HouseRentState extends State<HouseRentPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("测试出手房"),
        ),
      ),
    );
  }

}