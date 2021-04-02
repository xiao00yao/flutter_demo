import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pulltorefresh_flutter/pulltorefresh_flutter.dart';

///首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State {

  String customRefreshBoxIconPath="assets/images/2.0x/arrow_down.png";
  AnimationController customBoxWaitAnimation;
  int rotationAngle=0;
  String customHeaderTipText="快尼玛给老子松手！";
  String defaultRefreshBoxTipText="快尼玛给老子松手！";
  ///button等其他方式，通过方法调用触发下拉刷新
  ///
  TriggerPullController triggerPullController=new TriggerPullController();
  List<String> addStrs=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
  List<String> strs=["1","2","3","4","5","6","7","8","9","0"];
  ScrollController controller=new ScrollController();
  //For compatibility with ios ,must use RefreshAlwaysScrollPhysics ;为了兼容ios 必须使用RefreshAlwaysScrollPhysics
  ScrollPhysics scrollPhysics=new RefreshAlwaysScrollPhysics();
  var httpClient = new HttpClient();
  var url = "https://github.com/";
  var _result="";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 160,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage("assets/images/2.0x/index_bg.png"),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 12),
            width: 290,
            height: 28,
            margin: EdgeInsets.only(top: 36, left: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular((20.0))),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset(
                  "assets/images/2.0x/index_search_image.png",
                  height: 14,
                  width: 14,
                ),
                Center(
                  child: Text(
                    "输入楼盘名称/街道号/房源编号/业主手机号",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Positioned(
              width: 20,
              height: 20,
              right: 10,
              top: 42,
              child: Center(
                child: Image.asset(
                  "assets/images/2.0x/index_saoyisao.png",
                  width: 20,
                  height: 20,
                ),
              )),
          Positioned(

            child: PullAndPush(
              //如果你headerRefreshBox和footerRefreshBox全都自定义了，则default**系列的属性均无效，假如有一个RefreshBox是用默认的（在该RefreshBox Enable的情况下）则default**系列的属性均有效
              //If your headerRefreshBox and footerRefreshBox are all customizable，then the default** attributes of the series are invalid，
              // If there is a RefreshBox is the default（In the case of the RefreshBox Enable）then the default** attributes of the series are valid
              defaultRefreshBoxTipText: defaultRefreshBoxTipText,
              // headerRefreshBox: _getCustomHeaderBox(),
              triggerPullController:triggerPullController,

              //你也可以自定义底部的刷新栏；you can customize the bottom refresh box
              animationStateChangedCallback:(AnimationStates animationStates,RefreshBoxDirectionStatus refreshBoxDirectionStatus){
                _handleStateCallback( animationStates, refreshBoxDirectionStatus);
              },
              listView: new ListView.builder(
                //ListView的Item
                  itemCount: strs.length,//+2,
                  controller: controller,
                  physics: scrollPhysics,
                  itemBuilder: (BuildContext context,int index){
                    return  new Container(
                      height: 35.0,
                      child: new Center(
                        child: new Text(strs[index],style: new TextStyle(fontSize: 18.0),),
                      ),
                    );
                  }
              ),
              loadData: (isPullDown) async{
                await _loadData(isPullDown);
              },
              scrollPhysicsChanged: (ScrollPhysics physics) {
                //这个不用改，照抄即可；This does not need to change，only copy it
                setState(() {
                  scrollPhysics=physics;
                });
              },
            )

          )
        ],
      ),
    );
  }


  void _handleStateCallback(AnimationStates animationStates,RefreshBoxDirectionStatus refreshBoxDirectionStatus){
    switch (animationStates){
    //RefreshBox高度达到50,上下拉刷新可用;RefreshBox height reached 50，the function of load data is  available
      case AnimationStates.DragAndRefreshEnabled:
        setState(() {
          //3.141592653589793是弧度，角度为180度,旋转180度；3.141592653589793 is radians，angle is 180⁰，Rotate 180⁰
          rotationAngle=2;
        });
        break;

    //开始加载数据时；When loading data starts
      case AnimationStates.StartLoadData:
        setState(() {
          // customRefreshBoxIconPath="images/refresh.png";
          customHeaderTipText="正尼玛在拼命加载.....";
        });
        customBoxWaitAnimation.forward();
        break;

    //加载完数据时；RefreshBox会留在屏幕2秒，并不马上消失，这里可以提示用户加载成功或者失败
    // After loading the data，RefreshBox will stay on the screen for 2 seconds, not disappearing immediately，Here you can prompt the user to load successfully or fail.
      case AnimationStates.LoadDataEnd:
        customBoxWaitAnimation.reset();
        setState(() {
          rotationAngle = 0;
          if(refreshBoxDirectionStatus==RefreshBoxDirectionStatus.PULL) {
            // customRefreshBoxIconPath = "images/icon_cry.png";
            customHeaderTipText = "加载失败！请重试";
          }else if(refreshBoxDirectionStatus==RefreshBoxDirectionStatus.PUSH){
            defaultRefreshBoxTipText="可提示用户加载成功Or失败";
          }
        });
        break;

    //RefreshBox已经消失，并且闲置；RefreshBox has disappeared and is idle
      case AnimationStates.RefreshBoxIdle:
        setState(() {
          rotationAngle=0;
          defaultRefreshBoxTipText=customHeaderTipText="快尼玛给老子松手！";
          // customRefreshBoxIconPath="images/icon_arrow.png";
        });
        break;
    }
  }

  Widget _getCustomHeaderBox(){
    return new Container(
        color: Colors.grey,
        child:  new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Align(
              alignment: Alignment.centerLeft,
              child: new RotatedBox(
                quarterTurns: rotationAngle,
                child: new RotationTransition( //布局中加载时动画的weight
                  child: new Image.asset(
                    customRefreshBoxIconPath,
                    height: 45.0,
                    width: 45.0,
                    fit:BoxFit.cover,
                  ),
                  turns: new Tween(
                      begin: 100.0,
                      end: 0.0
                  )
                      .animate(customBoxWaitAnimation)
                    ..addStatusListener((animationStatus) {
                      if (animationStatus == AnimationStatus.completed) {
                        customBoxWaitAnimation.repeat();
                      }
                    }
                    ),
                ),
              ),
            ),

            new Align(
              alignment: Alignment.centerRight,
              child:new ClipRect(
                child:new Text(customHeaderTipText,style: new TextStyle(fontSize: 18.0,color: Color(0xffe6e6e6)),),
              ),
            ),
          ],
        )
    );
  }

  Future _loadData(bool isPullDown) async{
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        _result = await response.transform(utf8.decoder).join();
        setState(() {
          //拿到数据后，对数据进行梳理
          if(isPullDown){
            strs.clear();
            strs.addAll(addStrs);
          }else{
            strs.addAll(addStrs);
          }
        });
      } else {
        _result = 'error code : ${response.statusCode}';
      }
    } catch (exception) {
      _result = '网络异常';
    }
    print(_result);
  }
}

