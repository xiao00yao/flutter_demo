
class SPersonnelURL {

  static String BaseURL = "http://wf.t.jjw.com:6000/SPersonnel/";
  // static String LoginForMobile = "http://wf.t.jjw.com:6000/SPersonnel/API/Comm/LoginForMobile";
  static String LoginForMobile = BaseURL + "API/Comm/LoginForMobile"; //APP帐号密码登录
  static String AddDeviceApply = BaseURL + "API/Approval/AddDeviceApply"; //App登录异设备申请
  static String GetEmpMobileForEmpNo = BaseURL + "API/Comm/GetEmpMobileForEmpNo"; //获取经纪人手机号通过登录账号
  static String EditEmpPwd = BaseURL + "API/Comm/EditEmpPwd"; //APP修改密码
  static String ScanQR = BaseURL + "API/Comm/ScanQR"; //PC扫码登录-APP扫码
  static String GetConfig = BaseURL + "API/Comm/GetConfig"; //登录前获取配置信息(系统配置项）
  static String SwitchToCity = BaseURL + "API/Comm/SwitchToCity"; //切换城市


  static String GetEmpNavMenuList = BaseURL + "API/Comm/GetEmpNavMenuList" ;//获取人员菜单权限
  static String GetSystemTagConfig = BaseURL + "API/Comm/GetSystemTagConfig"; //获取体系配置信息
  static String GetUserNoticeListByPage = BaseURL + "API/Notice/GetUserNoticeListByPage"; //B端消息列表


  static String GetEmployeeDetail= BaseURL +"API/Employee/GetEmployeeDetail";//查询人员详细信息
  static String UpdateEmpWechaImgByAPP = BaseURL +"/API/Employee/UpdateEmpWechaImgByAPP";  //上传二维码
  static String UpdateEmpMobileByAPP = BaseURL + "/API/Employee/UpdateEmpMobileByAPP" ;  //修改手机号
  static String UpdateNoticeOneClickRead=BaseURL+"API/Notice/UpdateNoticeOneClickRead"; //一键已读

  static String GetEmpNoForMobile= BaseURL+"Api/Comm/GetEmpNoForMobile";//通过手机号获取经纪人账号信息
}
