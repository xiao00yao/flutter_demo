import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pulltorefresh_flutter/pulltorefresh_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

///首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> with TickerProviderStateMixin {
  String customRefreshBoxIconPath = "assets/images/2.0x/arrow_down.png";
  AnimationController customBoxWaitAnimation;
  int rotationAngle = 0;
  String customHeaderTipText = "快快松手！";
  String defaultRefreshBoxTipText = "快快松手！";

  // new TabController(length: 2,vsync: this)

  ///button等其他方式，通过方法调用触发下拉刷新
  ///
  TriggerPullController triggerPullController = new TriggerPullController();
  static String image = "assets/images/2.0x/";
  List<String> icons = [
    image + "index_xueyuan.png",
    image + "index_newhouse.png",
    image + "index_shenpi.png",
    image + "index_baobiao.png",
    image + "index_online_store.png",
    image + "index_order.png"
  ];
  List<String> icons1 = [
    image + "index_fangkan.png",
    image + "index_daikan.png",
    image + "index_jiaoguan.png",
  ];
  List<String> icnos2 = [
    image + "index_card.png",
    image + "index_market.png",
    image + "index_camera1.png",
    image + "index_video.png",
    image + "index_calputer1.png",
    image + "index_qa1.png",
  ];
  List<String> funName = ["学院", "新房", "审批", "报表", "网店", "房勘订单"];
  List<String> funName1 = ["房勘", "带看", "交管"];
  List<String> lists = ["新增房", "新增房", "新增房", "新增房", "新增房", "新增房", "新增房",];
  List<String> lists1 = ["新增客", "新增客", "新增客", "新增客", "新增客", "新增客", "新增客",];
  List<String> lists2 = ["电子名片", "营销素材", "房勘相机", "视频带看", "计算器", "Q&A",];
  List<String> counts = ["0","0","0","0","0","0","0","0", ];
  ScrollController controller = new ScrollController();

  //For compatibility with ios ,must use RefreshAlwaysScrollPhysics ;为了兼容ios 必须使用RefreshAlwaysScrollPhysics
  ScrollPhysics scrollPhysics = new RefreshAlwaysScrollPhysics();
  var httpClient = new HttpClient();
  var url = "https://github.com/";
  var _result = "";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    TabController mTabController = TabController(
        length: 2, vsync: this); //tab控制器
    PageController _pageController = PageController(); //pageview控制器
    return Scaffold(
        body: Stack(
          children: [
            Stack(
              overflow: Overflow.visible,
              // children: <Widget>[backgroundHeader(), summaryCash(screenWidth)],
              children: [
                Container(
                  height: 160,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image:
                        AssetImage("assets/images/2.0x/index_bg.png"),
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
                      borderRadius: new BorderRadius.circular(20.0)),
                  child: ListView(
                    physics: new NeverScrollableScrollPhysics(),
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

              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: PullAndPush(
                isPushEnable: false,
                defaultRefreshBoxTipText: defaultRefreshBoxTipText,
                triggerPullController: triggerPullController,
                animationStateChangedCallback: (AnimationStates animationStates,
                    RefreshBoxDirectionStatus refreshBoxDirectionStatus) {
                  _handleStateCallback(animationStates, refreshBoxDirectionStatus);
                },
                headerRefreshBox: headRefresh(),
                loadData: (isPullDown) async {
                  await _loadData(isPullDown);
                },
                scrollPhysicsChanged: (ScrollPhysics physics) {
                  //这个不用改，照抄即可；This does not need to change，only copy it
                  setState(() {
                    scrollPhysics = physics;
                  });
                },
                listView: ListView(
                  children: [
                    Positioned(

                      /// 该控件中的控件需要设置宽高不然会报错
                        top: 60,
                        left: 15,
                        right: 15,
                        child: Card(
                          margin: EdgeInsets.all(10),
                          //阴影度为8
                          elevation: 5,
                          child: Container(
                              padding: EdgeInsets.only(top: 10),
                              width: screenWidth,
                              height: 190,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: GridView(
                                physics: new NeverScrollableScrollPhysics(),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  // 每行个数
                                    crossAxisCount: 4,
                                    // 夸高比例
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                                children: List.generate(6, (index) {
                                  return getFuntion(
                                      icons[index], funName[index]);
                                }),
                              )),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                        height: 100,
                        child: GridView(
                          physics: new NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            // 每行个数
                              crossAxisCount: 4,
                              // 夸高比例
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                          children: List.generate(3, (index) {
                            return getFuntion(icons1[index], funName1[index]);
                          }),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Text(
                            "今日行程",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            image + "index_tip.png",
                            width: 16,
                            height: 34,
                          ),
                          SizedBox(width: 120,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 100,
                              child: TabBar(
                                // controller: tabController,indi catorColor: Colors.white,labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                labelColor: Colors.blue,
                                indicatorColor: Colors.blue,
                                // isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.label,
                                controller: mTabController,
                                tabs: <Tab>[
                                  new Tab(text: "租"),
                                  new Tab(text: "售"),
                                ],
                                onTap: (index) {
                                  // _pageController.jumpToPage(index);
                                  _pageController.animateToPage(
                                    index,
                                    curve: Curves.ease,
                                    //滚动时间
                                    duration: Duration(milliseconds: 500),);
                                },
                              ),
                            ),

                          )
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      height: 180,
                      child: PageView(
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        children: <Widget>[
                          getCard(screenWidth, counts, lists),
                          getCard(screenWidth, counts, lists1)
                        ],
                        onPageChanged: (index) {
                          mTabController.animateTo(index);
                        },

                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,top: 20,bottom: 20),
                        child: Text("百宝箱",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(15),
                      //阴影度为8
                      elevation: 5,
                      child: Container(
                          padding: EdgeInsets.only(top: 10),
                          width: screenWidth,
                          height: 190,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: GridView(
                            physics: new NeverScrollableScrollPhysics(),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              // 每行个数
                                crossAxisCount: 4,
                                // 夸高比例
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                            children: List.generate(6, (index) {
                              return getFuntion(
                                  icnos2[index], lists2[index]);
                            }),
                          )),
                    )

                  ],
                ),
              ),
            ),
            Positioned(
                right: 15,
                bottom: 180,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 52,
                        height: 33,
                        decoration: BoxDecoration(
                            color: Color(0xffE4EBF4),
                            borderRadius:BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text("录房",style: TextStyle(color: Color(0xFF485EA8)),),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: 52,
                        height: 33,
                        decoration: BoxDecoration(
                            color: Color(0xffE4EBF4),
                            borderRadius:BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text("录客",style: TextStyle(color: Color(0xFF485EA8)),)
                        ),
                      )
                    ],
                  ),
                )
            )

          ],
        ));
  }

  Widget headRefresh(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent
      ),
      child: Image.asset(image+"upload_loding.gif",width: 30,),
    );
  }

  Widget setCustomer(String conut, String name) {
    return Center(
      child: Column(
        children: [
          Text(conut, style: TextStyle(fontSize: 20),),
          Text(name, style: TextStyle(fontSize: 14),)
        ],
      ),
    );
  }



  Widget getCard(double screenWidth, List<String> list,
      List<String> listStr,{int itemCount = 7}) {
    return Card(
        margin: EdgeInsets.all(10),
        // elevation: 8,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              width: screenWidth,
              height: 139,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              child: GridView(
                physics: new NeverScrollableScrollPhysics(),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  // 每行个数
                    crossAxisCount: 4,
                    // 夸高比例
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                children: List.generate(itemCount, (index) {
                  return setCustomer(
                      list[index], listStr[index]);
                }),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("* 数据更新于:" + formatDate(DateTime.now(),
                    [yyyy, "-", mm, "-", dd, " ", hh, ":", mm]) + "最终数据以报表中心为准",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            )


          ],
        )
    );
  }

  ///模块
  Widget getFuntion(String iconName, String funtionName) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconName,
            width: 42,
            height: 42,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            funtionName,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  void _handleStateCallback(AnimationStates animationStates,
      RefreshBoxDirectionStatus refreshBoxDirectionStatus) {
    switch (animationStates) {
    //RefreshBox高度达到50,上下拉刷新可用;RefreshBox height reached 50，the function of load data is  available
      case AnimationStates.DragAndRefreshEnabled:
        setState(() {
          //3.141592653589793是弧度，角度为180度,旋转180度；3.141592653589793 is radians，angle is 180⁰，Rotate 180⁰
          rotationAngle = 2;
        });
        break;

    //开始加载数据时；When loading data starts
      case AnimationStates.StartLoadData:
        setState(() {
          // customRefreshBoxIconPath="images/refresh.png";
          customHeaderTipText = "拼命加载中.....";
        });
        // customBoxWaitAnimation.forward();
        break;

    //加载完数据时；RefreshBox会留在屏幕2秒，并不马上消失，这里可以提示用户加载成功或者失败
    // After loading the data，RefreshBox will stay on the screen for 2 seconds, not disappearing immediately，Here you can prompt the user to load successfully or fail.
      case AnimationStates.LoadDataEnd:
      // customBoxWaitAnimation.reset();
        setState(() {
          rotationAngle = 0;
          if (refreshBoxDirectionStatus == RefreshBoxDirectionStatus.PULL) {
            // customRefreshBoxIconPath = "images/icon_cry.png";
            customHeaderTipText = "刷新成功";
          } else if (refreshBoxDirectionStatus ==
              RefreshBoxDirectionStatus.PUSH) {
            defaultRefreshBoxTipText = "加载成功";
          }
        });
        break;

    //RefreshBox已经消失，并且闲置；RefreshBox has disappeared and is idle
      case AnimationStates.RefreshBoxIdle:
        setState(() {
          rotationAngle = 0;
          defaultRefreshBoxTipText = customHeaderTipText = "快快快松手！";
          // customRefreshBoxIconPath="images/icon_arrow.png";
        });
        break;
    }
  }

  Future _loadData(bool isPullDown) async {
    //延时执行
    Future.delayed(const Duration(milliseconds: 1000), () {
      Fluttertoast.showToast(msg: "加载完成了！！！");
    });
    // try {
    //   var request = await httpClient.getUrl(Uri.parse(url));
    //   var response = await request.close();
    //   if (response.statusCode == HttpStatus.ok) {
    //     _result = await response.transform(utf8.decoder).join();
    //     setState(() {
    //       //拿到数据后，对数据进行梳理
    //       if(isPullDown){
    //         strs.clear();
    //         strs.addAll(addStrs);
    //       }else{
    //         strs.addAll(addStrs);
    //       }
    //     });
    //   } else {
    //     _result = 'error code : ${response.statusCode}';
    //   }
    // } catch (exception) {
    //   _result = '网络异常';
    // }
    // print(_result);
  }
}
