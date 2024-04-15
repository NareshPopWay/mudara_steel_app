
class AppConstants {
  // static const String imageUrl = 'http://103.127.31.33:6007/';
  static const String imageUrl = 'http://116.72.8.100:6088/';
  static const String token = 'token';

  ///----------------------------------------API Strings---------------------------------///

  // static const String baseURL = 'http://192.168.29.168:6089/'; //Testing Server Url
  // static const String baseURL = 'http://116.72.10.168:6089/';// Testing Server Url

  static const String baseURL = 'http://116.72.8.100:6089/'; //Testing Server Url
  // static const String baseURL = 'http://103.209.145.199:6089/'; //Live Server Url

  ///Get APIS
  static const String tokenApi = 'token';
  static const String getAllClientList = 'api/EmployeeAPI/GetClientList?';
  static const String getDispatchRouteList = 'api/EmployeeAPI/GetDispatchRouteList';
  static const String getSalesOrderList = 'api/EmployeeAPI/GetSalesOrderList';
  static const String getClientWiseOrder = 'api/EmployeeAPI/GetClientWiseOrder';
  static const String getInwardList = 'api/EmployeeAPI/GetInwardList';
  static const String getEmployeeDetail = 'api/EmployeeAPI/GetEmployeeDetail';

  ///DropDown APIS
  static const String getProductList = 'api/EmployeeAPI/GetProductList';
  static const String getClientList = 'api/EmployeeAPI/GetAllClientList';
  static const String getAllRouteList = 'api/EmployeeAPI/GetAllRouteList';
  static const String getAllCountryList = 'api/EmployeeAPI/GetAllCountryList';
  static const String getStateList = 'api/EmployeeAPI/GetStateByCountryID';
  static const String getCityList = 'api/EmployeeAPI/GetCityByStateID?ID=';

  ///POST APIS
  static const String saveSalesOrderReturn = 'api/EmployeeAPI/SaveSalesOrderReturn';
  static const String saveDispatchDeliver = 'api/EmployeeAPI/SaveDispatchDeliver';
  static const String saveInward = 'api/EmployeeAPI/SaveInward';



}
