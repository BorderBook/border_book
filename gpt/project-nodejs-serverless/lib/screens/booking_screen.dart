import 'package:flutter/material.dart';
import 'package:your_project/services/api_service.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  DateTime birthdate;
  DateTime selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Time Slot'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              onSaved: (value) => firstName = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              onSaved: (value) => lastName = value,
            ),
            // Add date pickers for birthdate and selectedTime
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Book'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var response = await APIService.createBooking(firstName, lastName, birthdate, selectedTime);
      // Handle response and show QR code
    }
  }
}