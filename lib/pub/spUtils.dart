import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpKey{
    static String IsGuidle = "isGuidle"; //是否需要引导，用于第一次安装
    static String Gesture = "Gesture";//手势密码是否设置

    ///存数据
    static SpPutValue(int type,String key,Object value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        /// type =>1 bool 值
        switch(type){
            case 1:
                prefs.setBool(key, value as bool);
                break;
            case 2:


            default:
                break;
        }

    }

    ///拿数据  bool 类型
    static Future<bool> SpGetValue(String key) async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool value = prefs.getBool(key);
        return value;
    }

    static Future<SharedPreferences> getSharedPreferences() async {
        SharedPreferences prefs =  await SharedPreferences.getInstance();
        return prefs;
    }
}