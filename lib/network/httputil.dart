import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/network/httpmethod.dart';
import 'package:flutter_demo/network/spersonnel/resultbean/loginformobier_entity.dart';
import 'package:flutter_demo/network/spersonnel/spersonnelurl.dart';
import 'package:flutter_demo/utils/catch.dart';
import 'package:flutter_demo/utils/spUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';

class HttpUtil {
  static HttpUtil httpUtil;
  String baseUrl = "https://guangdiu.com/api/";
  final String XID = "177a957400024123bd87e7756454c445";
  final String token = "249b9c90b0084cb4ade8b30ede5d9fce";
  var SendSMS = "http://wf.t.jjw.com:6000/SComm/API/Comm/SendSMS"; //发送短信
  var CheckSMSCode =
      "http://wf.t.jjw.com:6000/SComm/API/Comm/CheckSMSCode"; //校验码验证
  var UpdateEmpMobileByAPP =
      "http://wf.t.jjw.com:6000/SPersonnel//API/Employee/UpdateEmpMobileByAPP"; //修改手机号
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
      onRequest: (RequestOptions options) async {
        /*. 拦截器请求 时 相关处理*/
        print('上传接口：${options.uri}');
        String spStringValue =
            await SpUtil.getSpStringValue(CacheConsts.LoginCookie);
        if (spStringValue != null && spStringValue.isNotEmpty) {
          String cookies = json.decode(spStringValue);
          // String cookieStr;
          // cookies.forEach((element) {
          //   if (!options.path.contains(CheckSMSCode)) {
          //     if (options.path.contains(UpdateEmpMobileByAPP)) {
          //
          //       cookieStr + element + ";";
          //     } else {
          //       if (element.contains("MsgCode")) {
          //
          //         cookieStr + element + ";";
          //       }
          //     }
          //   } else {
          //
          //     cookieStr + element + ";";
          //   }
          // });
          options.headers["Cookie"] = cookies; //给请求头添加Cookie
        }
        if (options.method == "POST") {
          Map hashMap = Map<String, String>();
          if (options.data is FormData) {
            FormData body = options.data as FormData;

            body.fields.forEach((element) {
              hashMap[element.key] = element.value;
            });
          }
          options.headers["ERPSignSecret"] = getSignNew(hashMap);
        } else if (options.method == "GET") {
          var headers = options.headers;
          var queryParameters = options.queryParameters;
          Map hashMap = Map<String, String>();
          queryParameters.forEach((key, value) {
            // hashMap[key] = utf8.encode(value);
            hashMap[key] = value;
          });
          String signNew = getSignNew(hashMap);
          options.headers["ERPSignSecret"] = getSignNew(hashMap);
          print("请求头" + options.headers.toString());
        }
      },
      onResponse: (e) async {
        if (e.request.path == SPersonnelURL.LoginForMobile) {
          List<String> header = e.headers["set-cookie"];
          if (header.isNotEmpty) {
            String spStringValue = await SpUtil.getSpStringValue(CacheConsts.LoginCookie); //获取缓存

            // List<String> cookies = new List();
            // // if (spStringValue != null && spStringValue.isNotEmpty) {
            // //   cookies = json.decode(spStringValue);
            // // }
            //
            // if (e.request.path.contains(SendSMS)) {
            //   cookies.forEach((element) {
            //     if (element.contains("MsgCode")) {
            //       cookies.remove(element);
            //     }
            //   });
            // } else {
            //   cookies.forEach((element) {
            //     if (element.contains("ERP")) {
            //       cookies.remove(element);
            //     }
            //   });
            // }
            // header.forEach((element) {
            //   if (element.contains("ERP") || element.contains("MsgCode")) {
            //     if (cookies.length>0) {
            //       cookies.insert(0, element);
            //     } else {
            //       cookies.add(element);
            //     }
            //   }
            // });

            SpUtil.setSpStrValue(CacheConsts.LoginCookie, json.encode(header[0]));
          }
          if (e.headers["set-cookie"].isNotEmpty) {
            Fluttertoast.showToast(
                msg: "缓存" + e.headers["set-coolie"].toString());
          }
        }
        print("返回请求头：" + e.headers.toString());
        // if(e.headers["Set-Cookie"].isNotEmpty){
        //   Fluttertoast.showToast(msg: "拿到Cookie了");
        // }
        /* 拦截器 请求到数据后的 相关处理*/
        // print('获取数据信息：$e');
      },
      onError: (e) {
        // Navigator.pop(Router.navigatorState.currentState.context);
        Fluttertoast.showToast(msg: "网络连接错误，请重试！");
        print('拦截器错误信息-->：$e');
      },
    ));

    ///代理  打版本是需注释掉 比较麻烦
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 192.168.10.28:8888"; //这里将localhost设置为自己电脑的IP，其他不变，注意上线的时候一定记得把代理去掉
      };
    };
  }

  final String SecretKey = "E10ADC3949BA59ABBE56E057F20F883E";

  ///获取签名新版
  String getSignNew(Map<String, String> map) {
    var mMap = Map<String, String>();
    mMap["data"] = getSignData(map);
    mMap["secret"] = SecretKey;
    String str = "";
    mMap.forEach((key, value) {
      str += key + value;
    });
    return md5.convert(utf8.encode(str)).toString();
  }

  //将map里面的key-value用=和&连接起来
  String getSignData(Map<String, String> map) {
    String str = "";
    map.forEach((key, value) {
      str += key + "=" + value + "&";
    });
    if (str.isNotEmpty) {
      str = str.substring(0, str.length);
    }
    return str;
  }

  ///获取App信息
  String getPackgeInfo() {
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

  ///post请求
  Future<Response> http(String url,String httpMethod,
      {options,
      data,
      callBack,
      onSendProgress,
      Function(dynamic) onSuccess,
      Function(dynamic,int) onSuccessByCode,
      Function(String) onError}) async {
    Response response;
    try {
      switch(httpMethod){
        case "POST":
          response = await dio.post<String>(
              url,
              data: data,
              onSendProgress: onSendProgress,
          );
          break;
        case "GET":
          response = await dio.get<String>(
              url,
            queryParameters: data
          );
          break;
          default:
            break;

      }
      print("--------   " + response.toString());
      if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
        int code = json.decode(response.data)['Code'];
        switch (code) {
          case 2000:
            onSuccess(json.decode(response.data));
            break;
          default:
            onSuccess(json.decode(response.data));
            Fluttertoast.showToast(msg: response.data['Msg']);
            break;
        }
      }else{
        onError("请求接口失败");
      }
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
    String url, {
    option, //添加请求头信息
    data,
    onSendProgress,
    Function(LoginformobierEntity) onSuccess,
    Function(String error) onError,
  }) async {
    print("*********  $url  *************");
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        onSendProgress: onSendProgress,
      );
      var responseData = response.data;
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        LoginformobierEntity mLoginformobierEntity =
            LoginformobierEntity().fromJson(responseData);
        onSuccess(mLoginformobierEntity);
      } else {
        onError(responseData['Msg']);
      }
      print('post返回结果$responseData');

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
