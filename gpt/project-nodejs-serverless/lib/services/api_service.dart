import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  static const String baseUrl = 'https://your-api-endpoint.amazonaws.com';

  static Future<Map<String, dynamic>> createBooking(String firstName, String lastName, DateTime birthdate, DateTime selectedTime) async {
    final response = await http.post(
      Uri.parse('$baseUrl/booking/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'birthdate': birthdate.toIso8601String(),
        'selectedTime': selectedTime.toIso8601String(),
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> validateBooking(String qrCode) async {
    final response = await http.post(
      Uri.parse('$baseUrl/booking/validate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'qrCode': qrCode,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> processBooking(String orderNumber, int capacityCount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/manager/process'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'orderNumber': orderNumber,
        'capacityCount': capacityCount,
      }),
    );
    return jsonDecode(response.body);
  }
}