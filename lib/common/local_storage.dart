import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
  static Future<String?> getToken()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
    static Future<String?> getCity()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('city');
  }
    static Future<String?> getEmployedType()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('employedType');
  }
    static Future<String?> getOccupation()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('occupation');
  }
    static Future<String?> getName()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }
      static Future<String?> getEducation()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('education');
  }
}