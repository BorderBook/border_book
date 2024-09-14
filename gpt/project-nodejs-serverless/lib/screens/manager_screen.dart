import 'package:flutter/material.dart';
import 'package:your_project/services/api_service.dart';

class ManagerScreen extends StatefulWidget {
  @override
  _ManagerScreenState createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  final _formKey = GlobalKey<FormState>();
  int capacityCount;
  String orderNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Capacity'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Capacity Count'),
              onSaved: (value) => capacityCount = int.parse(value),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Order Number'),
              onSaved: (value) => orderNumber = value,
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Process'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var response = await APIService.processBooking(orderNumber, capacityCount);
      // Handle response and show confirmation
    }
  }
}