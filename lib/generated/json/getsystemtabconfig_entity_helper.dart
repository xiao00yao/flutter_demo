import 'package:flutter_demo/network/spersonnel/resultbean/getsystemtabconfig_entity.dart';

getsystemtabconfigEntityFromJson(GetsystemtabconfigEntity data, Map<String, dynamic> json) {
	if (json['Msg'] != null) {
		data.msg = json['Msg'].toString();
	}
	if (json['Code'] != null) {
		data.code = json['Code'] is String
				? int.tryParse(json['Code'])
				: json['Code'].toInt();
	}
	if (json['Data'] != null) {
		data.data = (json['Data'] as List).map((v) => GetsystemtabconfigData().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> getsystemtabconfigEntityToJson(GetsystemtabconfigEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['Msg'] = entity.msg;
	data['Code'] = entity.code;
	data['Data'] =  entity.data?.map((v) => v.toJson())?.toList();
	return data;
}

getsystemtabconfigDataFromJson(GetsystemtabconfigData data, Map<String, dynamic> json) {
	if (json['C'] != null) {
		data.c = json['C'].toString();
	}
	if (json['V'] != null) {
		data.v = json['V'].toString();
	}
	return data;
}

Map<String, dynamic> getsystemtabconfigDataToJson(GetsystemtabconfigData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['C'] = entity.c;
	data['V'] = entity.v;
	return data;
}