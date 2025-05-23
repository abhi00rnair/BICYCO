import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:seproject/models/profilemodel.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<ProfileModel?> fetchStudentDetails(String idToken) async {
    final url = Uri.parse('$baseUrl/api/profile');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProfileModel.fromJson(data);
      } else {
        print('Failed to fetch student details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
