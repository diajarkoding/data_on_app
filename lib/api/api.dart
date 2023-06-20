import 'dart:convert';

import 'package:data_on_app/data/university_model.dart';
import 'package:http/http.dart' as http;

class UniversityApi {
  static Future<List<University>> getUniversities(int limit) async {
    final url = Uri.parse(
        'http://universities.hipolabs.com/search?country=Indonesia&limit=$limit');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;

      return jsonData.map((json) => University.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load universities');
    }
  }

  static Future<List<University>> searchUniversities(String query) async {
    final url = Uri.parse(
        'http://universities.hipolabs.com/search?name=$query&country=Indonesia');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;

      return jsonData.map((json) => University.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load search universities');
    }
  }
}
