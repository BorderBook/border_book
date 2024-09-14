import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:border_queue_management_app/models/booking.dart';

class BookingService {
  Future<void> createBooking(Booking booking) async {
    final response = await http.post(
      Uri.parse('https://your-api-endpoint.com/bookings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(booking.toJson()),
    );

    if (response.statusCode == 201) {
      // Booking created successfully
    } else {
      // Handle error
    }
  }
}