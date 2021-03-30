import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///个人中心
class PersionalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersionState();
  }
}

class PersionState extends State {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: InkWell(
          child: Text(
            "退出",
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
          onTap: (){ //点击事件
              Fluttertoast.showToast(msg: "退出登录！！！");
          },
        ),

      ),
    );
  }
}
