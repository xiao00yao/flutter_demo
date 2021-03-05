
import 'package:flutter/material.dart';

import 'appconfig.dart';

class StateEnv with ChangeNotifier {
  // 环境配置
  final Env config;

  StateEnv({this.config}) : super();

  // 获取环境模式
  EnvMode get mode => this.config.mode;

  // 获取接口配置
  String get api => this.config.api;

  // 获取应用名称
  String get appName => this.config.appName;
}