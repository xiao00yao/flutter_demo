import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_demo/network/spersonnel/resultbean/config_entity.dart';
import 'package:flutter_demo/utils/catch.dart';
import 'package:flutter_demo/utils/spUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../httputil.dart';
import 'spersonnelurl.dart';

class HttpSPersonnel {
  ///登录前获取配置信息(系统配置项）
  Future<Response> httpGetConfig<T>({
    callBack,
    onSendProgress,
    Function(ConfigEntity) onSuccess,
    Function(String error) onError,
  }) async {
    try {
      Response<String> response =
          await HttpUtil.getInstance().dio.get(SPersonnelURL.GetConfig);
      var responseData = response.data;
      Map userMap = json.decode(responseData);
      // GetConfig config = GetConfig.fromJson(userMap);
      ConfigEntity config = ConfigEntity().fromJson(userMap);

      var i = config.msg;
      if(response.statusCode == HttpStatus.ok|| response.statusCode == HttpStatus.created){
          if(config.code==2000){
            SpUtil.setSpStrValue(CacheConsts.LoginConfig, responseData);
            onSuccess(config);
          }else{
            Fluttertoast.showToast(msg: config.msg);
          }
      }else{
        onError(config.msg);
      }
      print('pett返回结果$i');
      return response;
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print("取消 " + e.message);
      } else {
        print(e);
      }
      return null;
    }
  }

  ///获取体系配置信息
  httpGetSystemTagConfig(
      Function(String) onSuccess,
      Function(String) onError,
      onSendProgress,
      ) async {
    try {
      Response response = await HttpUtil
          .getInstance()
          .dio
          .post(SPersonnelURL.GetSystemTagConfig);
      json.decode(response.data);

    }on DioError catch (e){

    }
  }
}
