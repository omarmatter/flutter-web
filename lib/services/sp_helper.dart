import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper spHelper = SPHelper._();

  SharedPreferences sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }
  setUserName(String value) async {
    sharedPreferences.setString('userName', value);
  }
  String getUserName() {
    String x = sharedPreferences.getString('userName');
    print(x);
    return x;
  }
  setToken(String value) async {
    sharedPreferences.setString('accessToken', value);
  }

 removeToken() async {
    sharedPreferences.remove('accessToken');
  }

  String getToken() {
    String x = sharedPreferences.getString('accessToken');
    print(x);
    return x;
  }

  setUserType(String value) async {
    sharedPreferences.setString('user_type', value);
  }

  removeUserType() async {
    sharedPreferences.remove('user_type');
  }

  String getUserType() {
    String x = sharedPreferences.getString('user_type');
    print(x);
    return x;
  }
}
