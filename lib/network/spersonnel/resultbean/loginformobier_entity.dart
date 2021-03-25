import 'package:flutter_demo/generated/json/base/json_convert_content.dart';
import 'package:flutter_demo/generated/json/base/json_field.dart';

class LoginformobierEntity with JsonConvert<LoginformobierEntity> {
	@JSONField(name: "Msg")
	String msg;
	@JSONField(name: "Code")
	int code;
	@JSONField(name: "Data")
	LoginformobierData data;
}

class LoginformobierData with JsonConvert<LoginformobierData> {
	@JSONField(name: "ID")
	String iD;
	@JSONField(name: "EmpCode")
	int empCode;
	@JSONField(name: "Name")
	String name;
	@JSONField(name: "Mobile")
	String mobile;
	@JSONField(name: "HeadImg")
	String headImg;
	@JSONField(name: "DepartName")
	String departName;
	@JSONField(name: "DepartCode")
	int departCode;
	@JSONField(name: "PositionCode")
	int positionCode;
	@JSONField(name: "PositionName")
	String positionName;
	@JSONField(name: "BusinessType")
	int businessType;
	@JSONField(name: "Logo")
	String logo;
	@JSONField(name: "OCityID")
	int oCityID;
	@JSONField(name: "CityInfo")
	List<LoginformobierDataCityInfo> cityInfo;
	@JSONField(name: "OSystemTag")
	int oSystemTag;
	@JSONField(name: "IsLogic")
	int isLogic;
}

class LoginformobierDataCityInfo with JsonConvert<LoginformobierDataCityInfo> {
	@JSONField(name: "Value")
	int value;
	@JSONField(name: "Text")
	String text;
}
