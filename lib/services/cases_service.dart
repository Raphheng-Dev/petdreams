import 'dart:convert';
import 'package:http/http.dart' as http;

class CasesService {
  final String baseUrl = 'https://yourapi.com/api'; // Replace with your API URL

  Future<List<Map<String, String>>> fetchPatients() async {
    final response = await http.get(Uri.parse('$baseUrl/patients'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((patient) => Map<String, String>.from(patient))
          .toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }

  Future<void> addPatient(Map<String, String> patient) async {
    final response = await http.post(
      Uri.parse('$baseUrl/patients'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(patient),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add patient');
    }
  }
}
