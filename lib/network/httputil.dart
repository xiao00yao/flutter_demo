import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';

class HttpUtil {
  static HttpUtil httpUtil;
  String baseUrl = "https://guangdiu.com/api/";
  final String XID = "177a957400024123bd87e7756454c445";
  final String token = "249b9c90b0084cb4ade8b30ede5d9fce";
  Dio dio;
  BaseOptions options;
  String versionName = "";
  String UUID = "";
  String Auth = "";

  static HttpUtil getInstance() {
    if (httpUtil == null) {
      httpUtil = HttpUtil();
    }
    return httpUtil;
  }

  HttpUtil() {
    getPackgeInfo().then((value) => versionName = value.version);
    getUniqueId().then((value) => UUID = value);
    getAuth();
    options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 3000,
        headers: {
          "ERPVersion": "V1", //默认V1  其他的需要监听地址重写
          "PlatForm": "2", //安卓端
          "Client-Mac": UUID, //获取唯一标识
          "Client-Version": versionName,
          "MC-ID": XID,
          "MC-Version": "V1",
          "Authorization": Auth,
        });

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        /*. 拦截器请求 时 相关处理*/
        print('上传接口：${options.uri}');
      },
      onResponse: (e) {
        /* 拦截器 请求到数据后的 相关处理*/
        print('获取数据信息：$e');
      },
      onError: (e) {
        // Navigator.pop(Router.navigatorState.currentState.context);
        Fluttertoast.showToast(msg: "网络连接错误，请重试！");
        print('拦截器错误信息-->：$e');
      },
    ));
  }

  ///获取App信息
  Future<PackageInfo> getPackgeInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  String getAuth() {
    String time = formatDate(DateTime.now(), [yyyy, MM, dd, HH, mm, ss]);
    String temp =
        md5.convert(utf8.encode(XID + token + time)).toString() + ":" + time;
    var content = utf8.encode(temp);
    Auth = base64Encode(content);
  }

  ///获取登录设备信息
  Future<String> getUniqueId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      print("ios唯一设备码：" + iosDeviceInfo.identifierForVendor);

      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      print("android唯一设备码：" + androidDeviceInfo.androidId);
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  // ignore: avoid_init_to_null
  ///get方法
  Future<Response> get(String url, {options, callBack, data}) async {
    print("--------  $url  --------");
    Response response;
    try {
      response = await dio.get(
        url,
      );
      print("--------   " + response.toString());
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

  ///post方法
  Future<Response> post<T>(
      String url, {options,
        callBack,
        data,
        onSendProgress,
        Function(T) onSuccess,
        Function(String error) onError,}) async {
    print("*********  $url  *************");
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        cancelToken: callBack,
        options: options,
        onSendProgress: onSendProgress,
      );
      var responseData = response.data;
      var i = responseData['msg'];
      if (responseData['code'] == 0) {
        onSuccess(responseData['data']);
      } else if (responseData['code'] == 200) {
        print('返回结果-->${responseData['code']}');
        onSuccess(responseData['data']);
      } else {
        print('指向这里');
        onError(responseData['msg']);
      }

      print('post返回结果$i');

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
