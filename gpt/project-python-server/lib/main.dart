import 'package:flutter/material.dart';
import 'package:border_queue_management_app/screens/booking_screen.dart';
import 'package:border_queue_management_app/screens/qr_verification_screen.dart';
import 'package:border_queue_management_app/screens/manager_screen.dart';

void main() {
  runApp(BorderQueueManagementApp());
}

class BorderQueueManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Border Queue Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookingScreen(),
      routes: {
        '/booking': (context) => BookingScreen(),
        '/qr_verification': (context) => QRVerificationScreen(),
        '/manager': (context) => ManagerScreen(),
      },
    );
  }
}