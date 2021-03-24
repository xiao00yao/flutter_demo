// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_demo/network/spersonnel/resultbean/config_entity.dart';
import 'package:flutter_demo/generated/json/config_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case ConfigEntity:
				return configEntityFromJson(data as ConfigEntity, json) as T;
			case ConfigData:
				return configDataFromJson(data as ConfigData, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case ConfigEntity:
				return configEntityToJson(data as ConfigEntity);
			case ConfigData:
				return configDataToJson(data as ConfigData);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (ConfigEntity).toString()){
			return ConfigEntity().fromJson(json);
		}	else if(type == (ConfigData).toString()){
			return ConfigData().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<ConfigEntity>[] is M){
			return data.map<ConfigEntity>((e) => ConfigEntity().fromJson(e)).toList() as M;
		}	else if(<ConfigData>[] is M){
			return data.map<ConfigData>((e) => ConfigData().fromJson(e)).toList() as M;
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