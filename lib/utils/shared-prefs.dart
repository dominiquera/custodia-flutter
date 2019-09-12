import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefsService {

  static Future<bool> getStepsState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('stepsClosed') ?? false;
  }

  static void setStepsState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('stepsClosed', true);
  }
}