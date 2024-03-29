// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_demo/network/spersonnel/resultbean/getsystemtabconfig_entity.dart';
import 'package:flutter_demo/generated/json/getsystemtabconfig_entity_helper.dart';
import 'package:flutter_demo/network/spersonnel/resultbean/config_entity.dart';
import 'package:flutter_demo/generated/json/config_entity_helper.dart';
import 'package:flutter_demo/network/spersonnel/resultbean/loginformobier_entity.dart';
import 'package:flutter_demo/generated/json/loginformobier_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case GetsystemtabconfigEntity:
				return getsystemtabconfigEntityFromJson(data as GetsystemtabconfigEntity, json) as T;
			case GetsystemtabconfigData:
				return getsystemtabconfigDataFromJson(data as GetsystemtabconfigData, json) as T;
			case ConfigEntity:
				return configEntityFromJson(data as ConfigEntity, json) as T;
			case ConfigData:
				return configDataFromJson(data as ConfigData, json) as T;
			case LoginformobierEntity:
				return loginformobierEntityFromJson(data as LoginformobierEntity, json) as T;
			case LoginformobierData:
				return loginformobierDataFromJson(data as LoginformobierData, json) as T;
			case LoginformobierDataCityInfo:
				return loginformobierDataCityInfoFromJson(data as LoginformobierDataCityInfo, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case GetsystemtabconfigEntity:
				return getsystemtabconfigEntityToJson(data as GetsystemtabconfigEntity);
			case GetsystemtabconfigData:
				return getsystemtabconfigDataToJson(data as GetsystemtabconfigData);
			case ConfigEntity:
				return configEntityToJson(data as ConfigEntity);
			case ConfigData:
				return configDataToJson(data as ConfigData);
			case LoginformobierEntity:
				return loginformobierEntityToJson(data as LoginformobierEntity);
			case LoginformobierData:
				return loginformobierDataToJson(data as LoginformobierData);
			case LoginformobierDataCityInfo:
				return loginformobierDataCityInfoToJson(data as LoginformobierDataCityInfo);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (GetsystemtabconfigEntity).toString()){
			return GetsystemtabconfigEntity().fromJson(json);
		}	else if(type == (GetsystemtabconfigData).toString()){
			return GetsystemtabconfigData().fromJson(json);
		}	else if(type == (ConfigEntity).toString()){
			return ConfigEntity().fromJson(json);
		}	else if(type == (ConfigData).toString()){
			return ConfigData().fromJson(json);
		}	else if(type == (LoginformobierEntity).toString()){
			return LoginformobierEntity().fromJson(json);
		}	else if(type == (LoginformobierData).toString()){
			return LoginformobierData().fromJson(json);
		}	else if(type == (LoginformobierDataCityInfo).toString()){
			return LoginformobierDataCityInfo().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<GetsystemtabconfigEntity>[] is M){
			return data.map<GetsystemtabconfigEntity>((e) => GetsystemtabconfigEntity().fromJson(e)).toList() as M;
		}	else if(<GetsystemtabconfigData>[] is M){
			return data.map<GetsystemtabconfigData>((e) => GetsystemtabconfigData().fromJson(e)).toList() as M;
		}	else if(<ConfigEntity>[] is M){
			return data.map<ConfigEntity>((e) => ConfigEntity().fromJson(e)).toList() as M;
		}	else if(<ConfigData>[] is M){
			return data.map<ConfigData>((e) => ConfigData().fromJson(e)).toList() as M;
		}	else if(<LoginformobierEntity>[] is M){
			return data.map<LoginformobierEntity>((e) => LoginformobierEntity().fromJson(e)).toList() as M;
		}	else if(<LoginformobierData>[] is M){
			return data.map<LoginformobierData>((e) => LoginformobierData().fromJson(e)).toList() as M;
		}	else if(<LoginformobierDataCityInfo>[] is M){
			return data.map<LoginformobierDataCityInfo>((e) => LoginformobierDataCityInfo().fromJson(e)).toList() as M;
		}
		throw Exception("not fond");
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}