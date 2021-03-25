import 'package:flutter_demo/network/spersonnel/resultbean/loginformobier_entity.dart';

loginformobierEntityFromJson(LoginformobierEntity data, Map<String, dynamic> json) {
	if (json['Msg'] != null) {
		data.msg = json['Msg'].toString();
	}
	if (json['Code'] != null) {
		data.code = json['Code'] is String
				? int.tryParse(json['Code'])
				: json['Code'].toInt();
	}
	if (json['Data'] != null) {
		data.data = LoginformobierData().fromJson(json['Data']);
	}
	return data;
}

Map<String, dynamic> loginformobierEntityToJson(LoginformobierEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['Msg'] = entity.msg;
	data['Code'] = entity.code;
	data['Data'] = entity.data?.toJson();
	return data;
}

loginformobierDataFromJson(LoginformobierData data, Map<String, dynamic> json) {
	if (json['ID'] != null) {
		data.iD = json['ID'].toString();
	}
	if (json['EmpCode'] != null) {
		data.empCode = json['EmpCode'] is String
				? int.tryParse(json['EmpCode'])
				: json['EmpCode'].toInt();
	}
	if (json['Name'] != null) {
		data.name = json['Name'].toString();
	}
	if (json['Mobile'] != null) {
		data.mobile = json['Mobile'].toString();
	}
	if (json['HeadImg'] != null) {
		data.headImg = json['HeadImg'].toString();
	}
	if (json['DepartName'] != null) {
		data.departName = json['DepartName'].toString();
	}
	if (json['DepartCode'] != null) {
		data.departCode = json['DepartCode'] is String
				? int.tryParse(json['DepartCode'])
				: json['DepartCode'].toInt();
	}
	if (json['PositionCode'] != null) {
		data.positionCode = json['PositionCode'] is String
				? int.tryParse(json['PositionCode'])
				: json['PositionCode'].toInt();
	}
	if (json['PositionName'] != null) {
		data.positionName = json['PositionName'].toString();
	}
	if (json['BusinessType'] != null) {
		data.businessType = json['BusinessType'] is String
				? int.tryParse(json['BusinessType'])
				: json['BusinessType'].toInt();
	}
	if (json['Logo'] != null) {
		data.logo = json['Logo'].toString();
	}
	if (json['OCityID'] != null) {
		data.oCityID = json['OCityID'] is String
				? int.tryParse(json['OCityID'])
				: json['OCityID'].toInt();
	}
	if (json['CityInfo'] != null) {
		data.cityInfo = (json['CityInfo'] as List).map((v) => LoginformobierDataCityInfo().fromJson(v)).toList();
	}
	if (json['OSystemTag'] != null) {
		data.oSystemTag = json['OSystemTag'] is String
				? int.tryParse(json['OSystemTag'])
				: json['OSystemTag'].toInt();
	}
	if (json['IsLogic'] != null) {
		data.isLogic = json['IsLogic'] is String
				? int.tryParse(json['IsLogic'])
				: json['IsLogic'].toInt();
	}
	return data;
}

Map<String, dynamic> loginformobierDataToJson(LoginformobierData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ID'] = entity.iD;
	data['EmpCode'] = entity.empCode;
	data['Name'] = entity.name;
	data['Mobile'] = entity.mobile;
	data['HeadImg'] = entity.headImg;
	data['DepartName'] = entity.departName;
	data['DepartCode'] = entity.departCode;
	data['PositionCode'] = entity.positionCode;
	data['PositionName'] = entity.positionName;
	data['BusinessType'] = entity.businessType;
	data['Logo'] = entity.logo;
	data['OCityID'] = entity.oCityID;
	data['CityInfo'] =  entity.cityInfo?.map((v) => v.toJson())?.toList();
	data['OSystemTag'] = entity.oSystemTag;
	data['IsLogic'] = entity.isLogic;
	return data;
}

loginformobierDataCityInfoFromJson(LoginformobierDataCityInfo data, Map<String, dynamic> json) {
	if (json['Value'] != null) {
		data.value = json['Value'] is String
				? int.tryParse(json['Value'])
				: json['Value'].toInt();
	}
	if (json['Text'] != null) {
		data.text = json['Text'].toString();
	}
	return data;
}

Map<String, dynamic> loginformobierDataCityInfoToJson(LoginformobierDataCityInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['Value'] = entity.value;
	data['Text'] = entity.text;
	return data;
}