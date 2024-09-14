import 'package:http/http.dart' as http;
import 'dart:convert';

class QRVerificationService {
  Future<String> verifyQRCode(String qrCode) async {
    final response = await http.post(
      Uri.parse('https://your-api-endpoint.com/verify_qr'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'qrCode': qrCode}),
    );

    if (response.statusCode == 200) {
      return 'Valid QR Code';
    } else {
      return 'Invalid QR Code';
    }
  }
}