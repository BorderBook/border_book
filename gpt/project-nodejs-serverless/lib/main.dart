import 'package:flutter/material.dart';
import 'screens/booking_screen.dart';
import 'screens/qr_code_screen.dart';
import 'screens/manager_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Border Crossing Queue Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookingScreen(),
      routes: {
        '/booking': (context) => BookingScreen(),
        '/qr_code': (context) => QRCodeScreen(),
        '/manager': (context) => ManagerScreen(),
      },
    );
  }
}