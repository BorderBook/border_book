import 'package:flutter/material.dart';
import 'package:border_queue_management_app/services/booking_service.dart';
import 'package:border_queue_management_app/models/booking.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdateController = TextEditingController();
  String _selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Time Slot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _birthdateController,
                decoration: InputDecoration(labelText: 'Birthdate'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your birthdate';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedTimeSlot,
                hint: Text('Select a Time Slot'),
                onChanged: (String newValue) {
                  setState(() {
                    _selectedTimeSlot = newValue;
                  });
                },
                items: <String>['08:00', '09:00', '10:00', '11:00']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a time slot';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Booking booking = Booking(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      birthdate: _birthdateController.text,
                      timeSlot: _selectedTimeSlot,
                    );
                    BookingService().createBooking(booking);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}