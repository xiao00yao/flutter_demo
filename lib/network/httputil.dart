import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/network/spersonnel/spersonnelurl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';

class HttpUtil {
  static HttpUtil httpUtil;
  String baseUrl = "https://guangdiu.com/api/";
  final String XID = "177a957400024123bd87e7756454c445";
  final String token = "249b9c90b0084cb4ade8b30ede5d9fce";
   Dio dio;
  BaseOptions options;
  static String versionName = "1.0.0+1";
  static String UUID = "3bb2fc527935b23";
  String Auth = "";

  static HttpUtil getInstance() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      versionName = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
    });

    if (httpUtil == null) {
      httpUtil = HttpUtil();
    }
    return httpUtil;
  }

  HttpUtil() {
    // getPackgeInfo();
    // getUniqueId();
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
        // ignore: unrelated_type_equality_checks
        if(options.path==SPersonnelURL.LoginForMobile){
            options.headers;
        }
        if(options.method=="POST"){
          Map hashMap = Map<String, String>();
          if (options.data is FormData) {
            FormData body = options.data as FormData;

            body.fields.forEach((element) {
              hashMap[element.key] = element.value;
            });
        }
          options.headers["ERPSignSecret"] = getSignNew(hashMap);
        }else if(options.method == "GET"){
            var headers = options.headers;
            var queryParameters = options.queryParameters;
            Map hashMap = Map<String, String>();
          queryParameters.forEach((key, value) {
            hashMap[key] = utf8.encode(value);
          });
          String signNew = getSignNew(hashMap);
            options.headers["ERPSignSecret"] = getSignNew(hashMap);
            print("请求头"+options.headers.toString());
        }
      },
      onResponse: (e) {
        if(e.request.path==SPersonnelURL.LoginForMobile){

        }
        print("返回请求头："+e.headers.toString());
          // if(e.headers["Set-Cookie"].isNotEmpty){
          //   Fluttertoast.showToast(msg: "拿到Cookie了");
          // }
        /* 拦截器 请求到数据后的 相关处理*/
        print('获取数据信息：$e');
      },
      onError: (e) {
        // Navigator.pop(Router.navigatorState.currentState.context);
        Fluttertoast.showToast(msg: "网络连接错误，请重试！");
        print('拦截器错误信息-->：$e');
      },
    ));


    ///代理  打版本是需注释掉 比较麻烦
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      // config the http client
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 192.168.10.28:8888"; //这里将localhost设置为自己电脑的IP，其他不变，注意上线的时候一定记得把代理去掉
      };
    };
  }

   final String SecretKey = "E10ADC3949BA59ABBE56E057F20F883E";

  ///获取签名新版
  String getSignNew( Map<String, String> map) {
    var mMap = Map<String, String>();
    mMap["data"] = getSignData(map);
    mMap["secret"] = SecretKey;
    String str = "";
    mMap.forEach((key, value) {
      str+=key + value;
    });
    return md5.convert(utf8.encode(str)).toString();
}

  //将map里面的key-value用=和&连接起来
  String getSignData( Map<String, String> map) {
    String str = "";
    map.forEach((key, value) {
      str+=key+"="+value+"&";
    });
    if(str.isNotEmpty){
      str = str.substring(0,str.length);
    }
    return str;
}

  ///获取App信息
  String getPackgeInfo()  {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      return packageInfo.version;
    });
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // versionName = packageInfo.version;
    // return packageInfo;
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
      UUID = iosDeviceInfo.identifierForVendor;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      print("android唯一设备码：" + androidDeviceInfo.androidId);
      UUID = androidDeviceInfo.androidId;
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
  Future<Response> httpLoginForMobile<T>(
      String url, {options,
        callBack,
        data,
        onSendProgress,
        Function(T) onSuccess,
        Function(String error) onError,}) async {
    print("*********  $url  *************")
    ;
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
      var i = responseData['Msg'];
      if (responseData['Code'] == 0) {
        onSuccess(responseData['Data']);
      } else if (responseData['Code'] == 200) {
        print('返回结果-->${responseData['Code']}');
        onSuccess(responseData['Data']);
      } else {
        print('指向这里');
        onError(responseData['Msg']);
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
