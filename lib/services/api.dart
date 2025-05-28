import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:seproject/models/cyclemodel.dart';
import 'package:seproject/models/finemodel.dart';
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

  Future<List<Cycle>> fetchCycleDetails(String idToken) async {
    final url = Uri.parse('$baseUrl/api/cycle');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Cycle.fromJson(json)).toList();
      } else {
        print('Failed to fetch cycle details: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Fine?> fetchfine(String rollNo) async {
    final url = Uri.parse('$baseUrl/api/fetchfine?rollNo=$rollNo');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final fine = Fine.fromJson(data);
      return fine;
    } else {
      return null;
    }
  }

  Future<http.Response> changecyclestate(String cycleid) async {
    final url = Uri.parse('$baseUrl/api/cyclebook');

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'cycleId': cycleid,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cycle status');
    }
    return response;
  }

  Future<http.Response> bookfine(String cycleid, String rollno) async {
    final url = Uri.parse('$baseUrl/api/bookfine');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'cycleId': cycleid,
        'rollNo': rollno,
      }),
    );

    if (response.statusCode == 200) {
      print('Fine initialized successfully');
    } else {
      print('Failed to initialize fine: ${response.body}');
    }
    return response;
  }
}
