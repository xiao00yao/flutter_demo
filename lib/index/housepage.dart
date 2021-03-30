import 'package:flutter/material.dart';
/// 房源界面
class HousePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HouseState();
  }

}

class HouseState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child:Text(
              "房源"
          ),
        ),
      ),
    );
  }

}