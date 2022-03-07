import 'dart:convert';
import 'package:beerchef_flutter/services/data_service.dart';

import 'models/user.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://localhost:8080";
  static User? _user;

  Future<User> login(String email, String password) async {
    Response res = await post(Uri.parse('$baseUrl/login'),
        body: {"email": email, "password": password});

    _user = User.fromJson(jsonDecode(res.body));
    HttpService.updateCookie(res);
    return _user as User;
  }

  Future<User> validate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookies = prefs.getString("cookies");
    if (cookies == null) throw "Can't validate without cookies";
    Response res =
        await post(Uri.parse('$baseUrl/login'), headers: {"cookie": cookies});

    _user = User.fromJson(jsonDecode(res.body));
    return _user as User;
  }

  User getUser() {
    if (_user == null) {
      throw "User is null";
    } else {
      return _user as User;
    }
  }
}
