import 'package:flutter_demo/generated/json/base/json_convert_content.dart';
import 'package:flutter_demo/generated/json/base/json_field.dart';

class ConfigEntity with JsonConvert<ConfigEntity> {
	@JSONField(name: "Msg")
	String msg;
	@JSONField(name: "Code")
	int code;
	@JSONField(name: "Data")
	List<ConfigData> data;
}

class ConfigData with JsonConvert<ConfigData> {
	@JSONField(name: "C")
	String c;
	@JSONField(name: "V")
	String v;
	@JSONField(name: "PC")
	String pC;
	@JSONField(name: "MinValue")
	int minValue;
	@JSONField(name: "MaxValue")
	int maxValue;
}
