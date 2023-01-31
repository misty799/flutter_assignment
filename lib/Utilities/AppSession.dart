import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  static void saveHeadlines(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("headlines", data);
  }

  static Future<String?> getHeadlines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("headlines");
  }
}
