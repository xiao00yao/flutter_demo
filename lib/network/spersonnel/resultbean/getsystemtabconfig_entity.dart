import 'package:flutter_demo/generated/json/base/json_convert_content.dart';
import 'package:flutter_demo/generated/json/base/json_field.dart';

class GetsystemtabconfigEntity with JsonConvert<GetsystemtabconfigEntity> {
	@JSONField(name: "Msg")
	String msg;
	@JSONField(name: "Code")
	int code;
	@JSONField(name: "Data")
	List<GetsystemtabconfigData> data;
}

class GetsystemtabconfigData with JsonConvert<GetsystemtabconfigData> {
	@JSONField(name: "C")
	String c;
	@JSONField(name: "V")
	String v;
}
