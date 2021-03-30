import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/network/httpmethod.dart';
import 'package:flutter_demo/personal/login.dart';
import 'package:flutter_demo/utils/andutils.dart';
import 'package:flutter_demo/utils/catch.dart';
import 'package:flutter_demo/utils/spUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///E:/FlutterDemo/flutter_demo/lib/index/index.dart';
import 'network/httputil.dart';
import 'network/spersonnel/httpspersonnel.dart';
import 'network/spersonnel/resultbean/config_entity.dart';
import 'network/spersonnel/spersonnelurl.dart';

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
      routes: {"login":(context)=>LoginHomePage(),"index":(context)=>IndexPage()},
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

  bool LoginFirstLaunch ; //是否第一次启用App

  int state1 = 0; //标记是否登录 0隐藏，1显示
  int state2 = 0; //标记是否登录 0隐藏，1显示

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
              offstage: !(state1==1), //false  显示  true 隐藏
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
          Container(
            child: Offstage(
              ///引导页
              offstage: !(state2==1), //true 隐藏，false 展示
              // offstage: guideIsShow, //true 隐藏，false 展示
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
                              SpUtil.setSpBoolValue(CacheConsts.LoginFirstLaunch, value: false);
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
          )
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
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return LoginHomePage();
    //
    //   ///跳转到登录界面
    // }));
    // Navigator.pushNamed(context, "login");

    Navigator.of(context).pushReplacementNamed("login"); //跳转后无返回
  }

  @override
  void initState() {

    setState(()  {
      isShowGuide();
    });
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    controller.addStatusListener((status) async {
      //添加监听
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        print("status is completed");
        //反向执行
        //controller.reverse();
        bool state = await SpUtil.getSpBoolValue(CacheConsts.LoginStatus,value: false);//登录状态
        if(!LoginFirstLaunch&&state==false){
          Navigator.of(context).pushReplacementNamed("login"); //跳转后无返回
        }

        if(state != null&&state==true){
          autoLogin();
        }

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

    // HttpSPersonnel().httpGetConfig<String>(
    //     onSuccess: (ConfigEntity config){
    //   Fluttertoast.showToast(msg :json.encode(config));
    // },
    // onError: (String errorMsg){
    //   Fluttertoast.showToast(msg: errorMsg);
    // }
    // );
   HttpUtil.getInstance().http(SPersonnelURL.GetConfig, HttpMethod.GET,
      onSuccess:(dynamic str) {
        ConfigEntity().fromJson(str);
        // Fluttertoast.showToast(msg: "获取到系统配置项"+json.encode(str));
      }
   );

    super.initState();
  }

  //登录后可直接登录
  autoLogin() async {
    Map map = Map();
    String loginEmpNo = await SpUtil.getSpStringValue(CacheConsts.LoginEmpNo);
    String loginPassword = await SpUtil.getSpStringValue(CacheConsts.LoginPassword);
    map["EmpNo"] = loginEmpNo;
    map["Pwd"] = loginPassword;
    map["SmsCode"] = "0";
    HttpUtil.getInstance().http(SPersonnelURL.LoginForMobile, HttpMethod.POST,data: map,onSuccess: (value){
      getPermission();
    });

  }
  //获取权限
  getPermission(){
    Map map = Map<String, dynamic>();
    map["platForm"] = "1";
    HttpUtil.getInstance().http( /// 获取体系配置信息
        SPersonnelURL.GetSystemTagConfig,
        HttpMethod.GET,
        data: {"platForm": "1"},
        onSuccess: (dynamic str){
          SpUtil.setSpStrValue(CacheConsts.LoginSystemTagConfig, json.encode(str));//保存体系配置信息
          HttpUtil.getInstance().http(///获取人员菜单权限
              SPersonnelURL.GetEmpNavMenuList,
              HttpMethod.GET,
              data: {"platForm": "1"},
              onSuccess: (dynamic str){
                SpUtil.setSpBoolValue(CacheConsts.LoginStatus, value: true);//标记登录状态
                // Navigator.of(context).push(MaterialPageRoute(builder:(context) {
                //   return(IndexPage());
                // }));
                Navigator.of(context).pushReplacementNamed("index");//跳转后不能返回
              }
          );
        }
    );
  }


  Future<bool> isShowGuide() async {
     LoginFirstLaunch = await SpUtil.getSpBoolValue(CacheConsts.LoginFirstLaunch,value: true);//默认返回true
    setState(() {
      if(LoginFirstLaunch){
        state1 = 0;
        state2 = 1;
      }else{
        state1 = 1;
        state2 = 0;
      }
    });
    return LoginFirstLaunch;
  }
}
