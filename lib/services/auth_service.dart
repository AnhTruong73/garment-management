import 'dart:convert';
import 'package:garment_management/common/config.dart';
import 'package:garment_management/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "${Config.baseUrl}/api/v1/auth/login";

  Future<LoginResponse?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'usrname': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 1 && jsonResponse['data'] != null) {
        final loginResponse = LoginResponse.fromJson(jsonResponse);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'username', loginResponse.data?.user?.usrname ?? '');
        await prefs.setString(
            'useremail', loginResponse.data?.user?.usrEmail ?? '');
        await prefs.setString(
            'usrid', loginResponse.data?.user?.usrId ?? '');
        await prefs.setString('token', loginResponse.data?.token ?? '');
        await prefs.setInt('userId', loginResponse.data?.user?.id ?? 0);

        return loginResponse;
      } else {
        print('Login failed: ${jsonResponse['message']}');
        return null;
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
      return null;
    }
  }
}
