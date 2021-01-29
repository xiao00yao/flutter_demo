import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/start/gesture_edit.dart';

///用户名面登陆界面
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginHomePage(),
    );
  }
}

class LoginHomePage extends StatefulWidget {

  @override
  _LoginHomePageState createState() {
    // implement createState
    return new _LoginHomePageState();
  }
}

class _LoginHomePageState extends State<LoginHomePage> {
  String username;
  bool clickEnabled = false;
  String password;
  Color bgColor = Color(0xffe8e8e8);
  Color textColor = Color(0xff999999);

  @override
  void initState() {
    print("登录界面初始化了");
  }


  @override
  void dispose() {
    print("登录界面销毁了");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(

        child:ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: 120.0,
          ),
          child: Column(
            //布局类组件
            mainAxisSize: MainAxisSize.max,
            //表示Row在主轴(水平)方向占用的空间，默认是MainAxisSize.max，表示尽可能多的占用水平方向的空间，
            crossAxisAlignment: CrossAxisAlignment.center,
            // 表示子组件在纵轴方向的对齐方式，Row的高度等于子组件中最高的子元素高度
            children: <Widget>[
              /* TODO 1, 放置登录页面logo或文字等等 */
              Container(
                //容器类组件(组合类,可以同时实现装饰、变换、限制的场景)
                height: 220.0,
                alignment: Alignment.center, //居中
                child: Image.asset(
                  "assets/images/login_top_pic.png",
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              /* TODO 2, 文本输入框区域 */
              // Container(
              //   color: Colors.white,
              //   alignment: Alignment.center,
              //   padding: EdgeInsets.only(left: 30.0, right: 30.0),
              //   margin: EdgeInsets.only(bottom: 10.0),
              //   child: new Container(
              //     child: buildForm(),
              //   ),
              // ),
              Container(
                  margin: EdgeInsets.only(
                      left: 45.0, right: 45.0, bottom: 40.0, top: 40.0),
                  //设置内间距
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFFcccccc), width: 0.5))),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/login_user_pic.png",
                          width: 19,
                          height: 19,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                            child: TextField(
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none, //去掉编辑框下划线
                                hintText: "请输入登录账号",
                              ),
                              onChanged: (value){ //监听变化
                                username = value;
                                setState(() {
                                  if(username.isNotEmpty&&username.length>=5&&password.isNotEmpty&&password.length>=5){
                                    bgColor = Color(0xff3eba70);
                                    textColor = Color(0xffffffff);
                                    clickEnabled = true;
                                  }else{
                                    bgColor = Color(0xffe8e8e8);
                                    textColor = Color(0xff999999);
                                    clickEnabled = false;
                                  }
                                });
                              },
                            ))
                      ],
                    ),
                  ),

              Container(
                  margin: EdgeInsets.only(
                      left: 45.0, right: 45.0, bottom: 40.0), //设置内间距
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFFcccccc), width: 0.5))),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/login_password_pic.png",
                          width: 19,
                          height: 19,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                            child: TextField(

                              decoration: InputDecoration(
                                border: InputBorder.none, //去掉编辑框下划线
                                hintText: "请输入密码",
                              ),
                              obscureText: true, //是否隐藏文本
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (value){ //监听变化
                                print(value);
                                password = value;
                                setState(() {
                                  if(username.isNotEmpty&&username.length>=5&&password.isNotEmpty&&password.length>=5){
                                     bgColor = Color(0xff3eba70);
                                     textColor = Color(0xffffffff);
                                     clickEnabled = true;
                                  }else{
                                    bgColor = Color(0xffe8e8e8);
                                    textColor = Color(0xff999999);
                                    clickEnabled = false;
                                  }
                                });
                              },
                            ))
                      ],
                    ),
                 ),

              /*TODO 登录按钮*/
              Container(
                margin: EdgeInsets.only(left: 45.0, right: 45.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          //"漂浮"按钮
                          padding: EdgeInsets.all(12.0),
                          color: bgColor,
                          textColor: textColor,
                          child: Text('登录',
                              style: TextStyle(fontSize: 17)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(2.0) //设置圆角
                          ),
                          onPressed: () {
                            print('点击了');
                            FocusScope.of(context).requestFocus(new FocusNode());
                            // print(nameController.text);
                            // print(pwdController.text);
                            if(clickEnabled){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return GestureEdit();
                              }));
                            }else{
                              return null;
                            }
                            // if ((formKey.currentState as FormState)
                            //     .validate()) {
                            // }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),

              /* TODO 3, 忘记密码 */
              Container(

                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context){
                      //   return GestureEdit();
                      // }));
                    },
                    child: Text(
                      '忘记密码?',
                      style: TextStyle(
                        fontSize: 15.0,
                        decoration: TextDecoration.none,//不要下滑线
                      ),
                    ),
                  )
                ),
              )
            ],
          ),
        ),


      )
    );
  }

  /* 定义两个container类 unameController和pwdController*/
  // TextEditingController nameController = new TextEditingController();
  // TextEditingController pwdController = new TextEditingController();
  // GlobalKey formKey = new GlobalKey<FormState>();
  //
  // Widget buildForm() {
  //   return Form(
  //     /* globalKey, 用于后面获取FormState*/
  //     key: formKey,
  //     /* 开启自动效验 */
  //     autovalidate: true,
  //     child: Column(
  //       children: <Widget>[
  //         TextFormField(
  //           autofocus: false,
  //           keyboardType: TextInputType.text,
  //           //键盘输入类型(七种类型)
  //           textInputAction: TextInputAction.next,
  //           //键盘动作按钮图标
  //           controller: nameController,
  //           //container
  //           maxLength: 12,
  //           //最大位数
  //           maxLengthEnforced: true,
  //           //超出maxLength,禁止输入
  //           decoration: InputDecoration(
  //             labelText: "用户名",
  //             hintText: "请输入用户名",
  //             icon: Icon(Icons.person),
  //           ),
  //           onChanged: (v) {
  //             //监听输入框值变化
  //             /*print("$v");*/
  //           },
  //           /* 效验用户名 */
  //           validator: (v) {
  //             return v.trim().length > 5 ? null : '请输入用户名';
  //           },
  //         ),
  //         TextFormField(
  //           autofocus: false,
  //           controller: pwdController,
  //           maxLength: 12,
  //           maxLengthEnforced: true,
  //           obscureText: true,
  //           //密码输入类型
  //           decoration: InputDecoration(
  //               labelText: "密码", hintText: "请输入密码", icon: Icon(Icons.lock)),
  //           validator: (v) {
  //             return v.trim().length > 5 ? null : '请输入密码';
  //           },
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 50.0),
  //           child: Row(
  //             children: <Widget>[
  //               Expanded(
  //                 child: RaisedButton(
  //                   //"漂浮"按钮
  //                   padding: EdgeInsets.all(12.0),
  //                   color: const Color(0xffc8a675),
  //                   textColor: Colors.white,
  //                   child: Text('登录', style: TextStyle(fontSize: 17)),
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(80.0) //设置圆角
  //                       ),
  //                   onPressed: () {
  //                     if ((formKey.currentState as FormState).validate()) {
  //                       print('点击了');
  //                       print(nameController.text);
  //                       print(pwdController.text);
  //                     }
  //                   },
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
