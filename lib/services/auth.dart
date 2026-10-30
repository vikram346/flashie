import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_struct_patch.dart';
import 'package:flashie/services/secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService {
  static const String BaseUrl = 'http://10.216.94.132:8000';




  static Future<String> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$BaseUrl/users/signup'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return "sign-up successful";
    }
    throw Exception(data["detail"] ?? "sign-up failed");
  }




  static Future<Map<String, dynamic>> signin({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$BaseUrl/users/signin"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email, "password": password}),
    );
    final data = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return data;
    }
    throw Exception(data["detail"] ?? "login failed");
  }




  static Future<List<dynamic>> fetchSets() async {
    final String? token = await StorageService.getToken();
    if (token == null) {
  throw Exception("Token not found. Please login again.");
}
    final response = await http.get(
      Uri.parse("$BaseUrl/sets/fetch"), headers: {'Authorization': 'Bearer $token'}
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    throw Exception("failed to load data: ${response.body}");
  }




  static Future<List<dynamic>> fetchcards({required int set_id}) async {
     final String? token = await StorageService.getToken();
    if (token == null) {
  throw Exception("Token not found. Please login again.");
}
    final response = await http.get(
      Uri.parse("$BaseUrl/cards/fetch?id=$set_id"), headers: {"Authorization": "Bearer $token"}
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    throw Exception("failed to load data: ${response.body}");
  }




  static Future<void> addSet({
    required String title,
    required String description,
    // required int userId,
  }) async {
    final String? token = await StorageService.getToken();
    if (token == null) {
  throw Exception("Token not found. Please login again.");
}
    final response = await http.post(
      Uri.parse("$BaseUrl/sets/add"),
      headers: {"Content-Type": "application/json","Authorization": "Bearer $token"},
      body: jsonEncode({
        "title": title,
        "description": description,
        // "user_id": userId,
      }),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add set: ${response.body}');
    }
  }




  static Future<void> addCard({
    required String question,
    required String answer,
    required int set_id
  }) async {
    final String? token = await StorageService.getToken();
    if (token == null) {
  throw Exception("Token not found. Please login again.");
}
    final response = await http.post(
      Uri.parse("$BaseUrl/cards/add"),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      body: jsonEncode({
        "answer": answer,
        "question": question,
        "set_id": set_id
      }),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("failed to add card: ${response.body}");
    }
  }




  static Future<void> deleteSet({required int id}) async{
    final String? token = await StorageService.getToken();
    if (token == null) {
  throw Exception("Token not found. Please login again.");
}
    final response = await http.delete(Uri.parse("$BaseUrl/sets/delete/$id"), headers: {"Authorization": "Bearer $token"});
    if(response.statusCode != 200){
      throw Exception("Failed to delete set: ${response.body}");
    }
  }




  static Future<void> deleteCard({required int id}) async{
    final String? token = await StorageService.getToken();
    if (token == null) {
  throw Exception("Token not found. Please login again.");
}
    final response = await http.delete(Uri.parse("$BaseUrl/cards/delete/$id"), headers: {"Authorization": "Bearer $token"});
    if(response.statusCode != 200){
      throw Exception("Failed to delete card: ${response.body}");
    }
  }
}
