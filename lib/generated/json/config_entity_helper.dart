import 'package:flutter_demo/network/spersonnel/resultbean/config_entity.dart';

configEntityFromJson(ConfigEntity data, Map<String, dynamic> json) {
	if (json['Msg'] != null) {
		data.msg = json['Msg'].toString();
	}
	if (json['Code'] != null) {
		data.code = json['Code'] is String
				? int.tryParse(json['Code'])
				: json['Code'].toInt();
	}
	if (json['Data'] != null) {
		data.data = (json['Data'] as List).map((v) => ConfigData().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> configEntityToJson(ConfigEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['Msg'] = entity.msg;
	data['Code'] = entity.code;
	data['Data'] =  entity.data?.map((v) => v.toJson())?.toList();
	return data;
}

configDataFromJson(ConfigData data, Map<String, dynamic> json) {
	if (json['C'] != null) {
		data.c = json['C'].toString();
	}
	if (json['V'] != null) {
		data.v = json['V'].toString();
	}
	if (json['PC'] != null) {
		data.pC = json['PC'].toString();
	}
	if (json['MinValue'] != null) {
		data.minValue = json['MinValue'] is String
				? int.tryParse(json['MinValue'])
				: json['MinValue'].toInt();
	}
	if (json['MaxValue'] != null) {
		data.maxValue = json['MaxValue'] is String
				? int.tryParse(json['MaxValue'])
				: json['MaxValue'].toInt();
	}
	return data;
}

Map<String, dynamic> configDataToJson(ConfigData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['C'] = entity.c;
	data['V'] = entity.v;
	data['PC'] = entity.pC;
	data['MinValue'] = entity.minValue;
	data['MaxValue'] = entity.maxValue;
	return data;
}