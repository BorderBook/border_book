import 'package:http/http.dart' as http;
import 'dart:convert';

class ManagerService {
  Future<int> getCurrentCapacity() async {
    final response = await http.get(
      Uri.parse('https://your-api-endpoint.com/capacity'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['capacity'];
    } else {
      // Handle error
      return 0;
    }
  }

  Future<void> setCapacity(int capacity) async {
    final response = await http.post(
      Uri.parse('https://your-api-endpoint.com/set_capacity'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'capacity': capacity}),
    );

    if (response.statusCode == 200) {
      // Capacity updated successfully
    } else {
      // Handle error
    }
  }
}