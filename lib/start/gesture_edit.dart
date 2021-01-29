import 'package:flutter/material.dart';
import 'package:flutter_demo/personal/index.dart';
import 'package:flutter_demo/pub/andutils.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

///手势密码设置

class GestureEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GestureEditState();
  }
}

class GestureEditState extends State {
  List<int> result = [];
  String strHint = "请绘制手势密码"; //绘制手势密码
  bool isFirstDraw = true;

  Color strHintColor = Color(0xFF333333);

  SharedPreferences prefs;

  ///缓存类
  ShakeAnimationController _shakeAnimationController;

  ///抖动动画控制器

  @override
  void initState() {
    getSp();
    _shakeAnimationController = ShakeAnimationController();
  }

  void getSp() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
            child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 8),
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return IndexPage(); //跳转到首页
                    }));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "取消",
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13.0,
                          decoration: TextDecoration.none, //取消下划线
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Image.asset(
                  "assets/images/empty_head_pic.png",
                  width: 75,
                  height: 75,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "小明同学",
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 13.0,
                      decoration: TextDecoration.none, //隐藏下划线
                      fontWeight: FontWeight.w100),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 30, bottom: 30),
              //   child: Text(
              //     "result: ${result.toString()}",
              //     style: TextStyle(
              //         fontSize: 24,
              //         color: Colors.blue,
              //         fontWeight: FontWeight.bold,
              //         decoration: TextDecoration.none),
              //   ),
              // ),

              ShakeAnimationWidget(
                shakeAnimationType: ShakeAnimationType.LeftRightShake,
                //震动方向
                shakeAnimationController: _shakeAnimationController,
                //震动控制器
                shakeRange: 0.2,
                //震动幅度
                isForward: false,
                //不开启抖动
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 20),
                  child: Text(
                    strHint,
                    style: TextStyle(
                        fontSize: 13.0,
                        decoration: TextDecoration.none,
                        color: strHintColor,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),

              GestureView(
                lineWidth: 1,
                ringWidth: 1,
                selectColor: Color(0xff3eba70),
                unSelectColor: Color(0xffe8e8e8),
                circleRadius: 10,
                immediatelyClear: true,
                size: MediaQuery.of(context).size.width,
                onPanUp: (List<int> items) {
                  print(result.toString());
                  setState(() {
                    print("是否是第一次设置$isFirstDraw");
                    if (items.length < 4) {
                      strHint = "手势密码不少于4格，请重试";
                      strHintColor = Colors.red;
                      return;
                    }

                    if (isFirstDraw) {
                      if (items.length >= 4) {
                        isFirstDraw = false;
                        result = items;
                        strHint = "请再次绘制以确认";
                        strHintColor = Colors.red;
                        return;
                      }
                    }

                    if (!isFirstDraw) {
                      if (result == items) {
                        strHint = "设置成功";
                        // prefs.setString(AndUtils.GestureAnswer(), result.toString());
                        strHintColor = Color(0xff3eba70);

                        ///返回到上一页跳转到首页
                      } else {
                        strHint = "与上一次绘制不一致，请重新绘制";
                        strHintColor = Colors.red;
                        print("与上一次绘制不一致，请重新绘制");
                        if (!_shakeAnimationController.animationRunging) {
                          //动画没有执行时执行动画
                          _shakeAnimationController.start(shakeCount: 1);
                          print("开始抖动");
                        }

                        isFirstDraw = true;
                      }
                    }

                    result = items;
                  });
                },
              ),
            ],
          ),
        )),
        Container(
          color: Colors.white,
          child: Offstage(
            offstage: false,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 35,bottom: 35),
                    child: Center(
                      child: Text("重设手势密码"),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text("使用账号密码登录 >"),
                  ),
                ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
