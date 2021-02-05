import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/personal/login.dart';
import 'package:flutter_demo/pub/andutils.dart';
import 'package:flutter_demo/pub/catch.dart';
import 'package:flutter_demo/pub/spUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  //StatelessWidget  无状态
  var guideImgs = [
    //加载的图片必须写全称，后缀也必须写上，不然无法显示
    "assets/images/start_view_one.png",
    "assets/images/start_view_two.png",
    "assets/images/start_view_three.png"
  ]; //引导页图片

  AnimationController controller; //动画控制器

  bool LoginFirstLaunch = true; //是否第一次启用App

  ///是否需要引导页
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 50,
            left: 50,
            right: 50,
            child: Offstage(
              offstage: false, //false  显示  true 隐藏
              // child: Image.asset("assets/images/start_image_bg.png"),
              child: FadeTransition(
                ///渐变动画
                opacity: controller,
                child: Image.asset(
                  "assets/images/start_image_bg.png",
                  alignment: Alignment.bottomCenter,
                  width: 200,
                  height: 60,
                ),
              ),
            ),
          ),
          Offstage(
            ///引导页
            offstage: !LoginFirstLaunch, //true 隐藏，false 展示
            child: Swiper(
              //轮播图
              loop: false,
              //是否循环
              // autoplay: true,//自动播放
              itemBuilder: (BuildContext context, int index) {
                if (index != 2) {
                  //不是最后一页时只展示图片
                  return new Image.asset(
                    guideImgs[index],
                    fit: BoxFit.cover,
                  );
                } else {
                  //最后一页时展示按钮
                  return Stack(
                    alignment: Alignment(0, 0), //居中展示
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(
                        guideImgs[index],
                        fit: BoxFit.fitHeight,
                      ),
                      Positioned(
                        bottom: 50,
                        child: RaisedButton(
                          child: Text("开启新篇章"),
                          textColor: Color(0xFF16C192),
                          color: Color(0xFFFFFFFF),
                          // splashColor: Colors.black,
                          highlightColor: Colors.green,
                          onPressed: (){
                            beginNewWorld();
                          },
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color(0xFF28CA9E), width: 0.2)),
                        ),
                      )
                    ],
                  );
                }
              },
              itemCount: this.guideImgs.length,

              //配置指示器
              pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder( //对指示器进行设置
                      activeColor: Color(0xFF16C192),
                      color: Color(0xFFEAEAEA))),
            ),
          ),
        ],
      ),
    );
  }

  /// Future 对象表示异步操作的结果，我们通常通过then（）来处理返回的结果
  /// async 用于标明函数是一个异步函数，其返回值类型是Future类型
  /// await 用来等待耗时操作的返回结果，这个操作会阻塞到后面的代码
  void beginNewWorld()  {//async
    //开启新章程
    // SpKey.SpPutValue(1, CacheConsts.LoginFirstLaunch, false); //记录是否第一次启用App
    // SpKey.SpGetValue(CacheConsts.LoginFirstLaunch).then((value) => LoginFirstLaunch = value);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if(prefs.getBool(CacheConsts.LoginStatus)&&""!=prefs.getString(CacheConsts.LoginEmpInfoBean)){ //标记登陆状态，登录人信息
    //     if(prefs.getString(AndUtils.GestureAnswer()).isNotEmpty&&prefs.getBool(AndUtils.GestureAnswerSwitch())){
    //         ///条状到手势密码验证界面
    //     }else{
    //         ///账号密码登陆界面
    //     }
    // }else{
    //     ///跳转到登录界面
    // }
    // ignore: missing_return
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginHomePage();

      ///跳转到登录界面
    }));
  }

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    controller.addStatusListener((status) {
      //添加监听
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        print("status is completed");
        //反向执行
        //controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        print("status is dismissed");
        //controller.forward();
      } else if (status == AnimationStatus.forward) {
        print("status is forward");
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
        print("status is reverse");
      }
    });
    //动画开始
    controller.forward(); //开始动画
  }
}
