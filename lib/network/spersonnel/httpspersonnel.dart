

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_demo/network/spersonnel/resultbean/config_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../httputil.dart';
import 'spersonnelurl.dart';

class HttpSPersonnel {
  ///get方法
  Future<Response> httpGetConfig<T>(
    {
      callBack,
      onSendProgress,
      Function(String) onSuccess,
      Function(String error) onError,
    }
  ) async {
    try {
      Response<String> response = await HttpUtil.getInstance().dio.get(SPersonnelURL.GetConfig);
      var responseData = response.data;
      Map userMap= json.decode(responseData);
      // GetConfig config = GetConfig.fromJson(userMap);
      ConfigEntity config = ConfigEntity().fromJson(userMap);

      var i = config.msg;
      if (config.code == 2000) {
        var str = json.encode(config.data);
        // String str = config.data.toString();
        onSuccess(str);
      } else if (config.code == 200) {
        // print('返回结果-->${responseData['Code']}');
        // onSuccess(responseData['Data']);
      } else {
        print('指向这里');
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
}
