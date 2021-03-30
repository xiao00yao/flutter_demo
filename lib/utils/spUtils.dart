
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil{
    static String IsGuidle = "isGuidle"; //是否需要引导，用于第一次安装
    static String Gesture = "Gesture";//手势密码是否设置
    static SharedPreferences prefs;

    static Future<SharedPreferences> getSharedPreferences() async {
        if(prefs==null){
            prefs =  await SharedPreferences.getInstance();
        }
        return prefs;
    }

    //初始化工具类
    static Future<SharedPreferences> initSP() async {
        if(prefs==null){
            prefs =  await SharedPreferences.getInstance();
        }
        return prefs;
    }
    ///存储字符串数据
    static setSpStrValue(String key,dynamic value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(key, value);
    }
    ///获取字符串缓存数据
    static Future<String> getSpStringValue(String key) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String string = prefs.getString(key);
        return string;
    }

    ///存储布尔类型数据
    static setSpBoolValue(String key,{bool value = false}) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(key, value);
    }
    ///获取布尔类型缓存数据
    static Future<bool> getSpBoolValue(String key,{bool value= false}) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool mBool ;
        if(prefs.getBool(key)==null){
            mBool = value;
        }else{
            mBool = prefs.getBool(key);
        }

        return mBool;
    }

    /// 保存数据
    static saveData<T>(String key, T value)  {
        if(prefs==null){
            return null;
        }
        switch (T) {
            case String:
                prefs.setString(key, value as String);
                break;
            case int:
                prefs.setInt(key, value as int);
                break;
            case bool:
                prefs.setBool(key, value as bool);
                break;
            case double:
                prefs.setDouble(key, value as double);
                break;
        }
    }

    ///获取数据
    static Future<T> getData<T>(String key) {
        dynamic data;
        if(prefs==null){
            return null;
        }
        switch (T) {
            case String:
                data = prefs.getString(key) as T;
                break;
            case int:
                data = prefs.getInt(key) as T;
                break;
            case bool:
                data = prefs.getBool(key) as T;
                break;
            case double:
                data = prefs.getDouble(key) as T;
                break;
        }
        return data;
    }
}