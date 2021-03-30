import 'package:flutter/material.dart';

///客源界面
class CustomerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CustomerState();
  }

}

class CustomerState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child:Text(
              "客源"
          ),
        ),
      ),
    );
  }

}