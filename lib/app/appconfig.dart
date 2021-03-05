
import 'package:flutter/material.dart';

///多环境
// 环境标识
enum EnvMode {
  PRODUCTION, // 生产环境
  DEVELOPMENT, // 开发环境
  TEST, // 测试环境
  UAT, // 预发布环境
}

class Env {
  // 环境标识
  final EnvMode mode;

  // 接口参数
  final String api;

  // 应用基础配置
  final String appName;

  Env({
    this.mode = EnvMode.PRODUCTION,
    this.api = '',
    this.appName = 'Flutter 学习',
  }) : super();

}
