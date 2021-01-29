import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IndexPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return IndexState();
  }

}


class IndexState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child :Text(
              "欢迎来到首页"
          )
      ),
    );
  }

}