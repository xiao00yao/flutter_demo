import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/appconfig.dart';
import 'app/stateenv.dart';


void main() {
  // 实例化应用
  runApp(
    // 支持多个状态管理
    MultiProvider(
      providers: [
        // 环境配置
        ChangeNotifierProvider(
          create: (BuildContext context) => StateEnv(
            config: Env(
              mode: EnvMode.DEVELOPMENT, // 使用开发环境
              api: 'http://127.0.0.1:3000', // 指定该环境对应的数据请求接口
            ),
          ),
        ),
      ],
      child: MyApp(), // App 挂载
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: Provider.of<StateEnv>(context, listen: false).appName,
      debugShowCheckedModeBanner: Provider.of<StateEnv>(context).mode == EnvMode.DEVELOPMENT, // 是否显示右上角 debug 徽标
      home: Container(
        child: Text(
          "测试",
          style: TextStyle(
            fontSize: 20,
            color: Colors.red
          ),
        ),
      ),
    );
  }
}


