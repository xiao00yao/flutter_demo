import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/andutils.dart';
import 'package:pulltorefresh_flutter/pulltorefresh_flutter.dart';

/**
 * 二手房界面
 */
class HouseSalePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HouseSaleState();
  }

}

class HouseSaleState extends State<HouseSalePage>{
  TriggerPullController triggerPullController = new TriggerPullController();
  String defaultRefreshBoxTipText = "下拉刷新";
  ScrollPhysics scrollPhysics = new RefreshAlwaysScrollPhysics();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(child: Row(
              children: [
                item("区域"),
                item("价格"),
                item("楼层"),
                item("快查"),
                item("多选"),
              ],
            ),),
            Expanded(child: PullAndPush(
              defaultRefreshBoxTipText: defaultRefreshBoxTipText,
                triggerPullController: triggerPullController,
                headerRefreshBox: headRefresh(),
                animationStateChangedCallback: (AnimationStates animationStates,
                    RefreshBoxDirectionStatus refreshBoxDirectionStatus) {
                  _handleStateCallback(animationStates, refreshBoxDirectionStatus);
                },
                loadData: (isPullDown){

                },
                scrollPhysicsChanged: (ScrollPhysics physics) {
                  //这个不用改，照抄即可；This does not need to change，only copy it
                  setState(() {
                    scrollPhysics = physics;
                  });
                },
                listView: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Text("测试"),
                    Text("ceshi")
                  ],
                )))
          ],
        ),
      ),
    );
  }

  Widget item(String itemName){
    return Expanded(
      child: InkWell( //点击事件
        child: Row(
          children: [
            Text(itemName),
            Image.asset(AndUtils.image+"arrow_down.png")
          ],
        ),
        onTap: (){

        },
      )
    );
  }


  //下拉刷新布局
  Widget headRefresh(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent
      ),
      child: Image.asset(AndUtils.image+"upload_loding.gif",width: 30,),
    );
  }

  //刷新状态监听
  void _handleStateCallback(AnimationStates animationStates,
      RefreshBoxDirectionStatus refreshBoxDirectionStatus) {
    switch (animationStates) {
    //RefreshBox高度达到50,上下拉刷新可用;RefreshBox height reached 50，the function of load data is  available
      case AnimationStates.DragAndRefreshEnabled:
        setState(() {
          //3.141592653589793是弧度，角度为180度,旋转180度；3.141592653589793 is radians，angle is 180⁰，Rotate 180⁰
        });
        break;

    //开始加载数据时；When loading data starts
      case AnimationStates.StartLoadData:
        setState(() {
          // customRefreshBoxIconPath="images/refresh.png";
          defaultRefreshBoxTipText = "拼命加载中.....";
        });
        // customBoxWaitAnimation.forward();
        break;

    //加载完数据时；RefreshBox会留在屏幕2秒，并不马上消失，这里可以提示用户加载成功或者失败
    // After loading the data，RefreshBox will stay on the screen for 2 seconds, not disappearing immediately，Here you can prompt the user to load successfully or fail.
      case AnimationStates.LoadDataEnd:
      // customBoxWaitAnimation.reset();
        setState(() {
          if (refreshBoxDirectionStatus == RefreshBoxDirectionStatus.PULL) {
            // customRefreshBoxIconPath = "images/icon_cry.png";
            defaultRefreshBoxTipText = "刷新成功";
          } else if (refreshBoxDirectionStatus ==
              RefreshBoxDirectionStatus.PUSH) {
            defaultRefreshBoxTipText = "加载成功";
          }
        });
        break;

    //RefreshBox已经消失，并且闲置；RefreshBox has disappeared and is idle
      case AnimationStates.RefreshBoxIdle:
        setState(() {

          defaultRefreshBoxTipText = "快快快松手！";
          // customRefreshBoxIconPath="images/icon_arrow.png";
        });
        break;
    }
  }

}