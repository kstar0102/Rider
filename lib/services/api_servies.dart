import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl =
      "http://54.173.7.68/api/"; // Replace with your actual base URL
  
  var token;
  Future<void> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token') ?? '{}')['token'];
  }

  Future<Map<String, dynamic>> authData(
      Map<String, dynamic> data, String apiUrl) async {
    var fullUrl = Uri.parse(baseUrl + apiUrl); // Use Uri.parse to parse the URL
    await getToken(); // Ensure the token is retrieved before making the request
    final response = await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to authenticate');
    }
  }
  Future<Map<String, dynamic>> getData(String apiUrl) async {
    var fullUrl = Uri.parse(baseUrl + apiUrl);
    await getToken();
    final response = await http.get(fullUrl, headers: _setHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Map<String, String> _setHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  Future<Map<String, dynamic>> registerUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('${baseUrl}registerUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': user.email,
        'password': user.password,
        'first_name': user.firstName,
        'last_name' : user.lastName,
        'phone_number': user.phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }

  static Future<int> loginUser(String email, String password, String method) async {
    final String flag = method == 'email' ? 'email' : 'phone_number'; // Determine the flag based on the method
    final url = Uri.parse('http://54.173.7.68/api/loginUser');
    print("streets===========>");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'method': flag, flag: email, 'password': password});
    final response = await http.post(url, headers: headers, body: body);
    
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData.containsKey('access_token')) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['access_token']);
        await prefs.setString('user', responseData['user']);
      } else {
        throw Exception('Access token not found');
      }
      return response.statusCode;
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }
}
