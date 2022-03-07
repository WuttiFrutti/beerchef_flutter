import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  final String baseUrl = "http://localhost:8080/";


  static Future<void> updateCookie(Response response) async {
    String? rawCookie = response.headers['set-cookie'];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      prefs.setString("cookies", (index == -1) ? rawCookie : rawCookie.substring(0, index));
    }
  }

}
