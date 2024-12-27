import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseUrl = "http://16.16.68.215";

  static Future<void> postData(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl$endpoint');

    print(url);
    print(data);

    try {
      await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
    } catch (error) {
      print(error);
    }
  }
}
