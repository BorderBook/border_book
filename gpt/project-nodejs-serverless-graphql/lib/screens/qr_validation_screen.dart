import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../graphql_client.dart';

class QRValidationScreen extends StatefulWidget {
  @override
  _QRValidationScreenState createState() => _QRValidationScreenState();
}

class _QRValidationScreenState extends State<QRValidationScreen> {
  final _formKey = GlobalKey<FormState>();
  String qrCodeData = '';
  String bookingDetails = '';

  void _validateBooking() async {
    final client = GraphQLConfig.clientToQuery();
    final String validateBookingQuery = """
      query ValidateBooking(\$securityCode: ID!) {
        validateBooking(securityCode: \$securityCode) {
          id
          firstName
          lastName
          birthdate
          selectedTime
          orderNumber
          processed
        }
      }
    """;

    final result = await client.query(
      QueryOptions(
        document: gql(validateBookingQuery),
        variables: {
          'securityCode': qrCodeData,
        },
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
    } else {
      setState(() {
        bookingDetails = result.data['validateBooking'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Validation Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'QR Code Data'),
                onChanged: (value) {
                  setState(() {
                    qrCodeData = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateBooking,
                child: Text('Validate Booking'),
              ),
              SizedBox(height: 20),
              if (bookingDetails.isNotEmpty)
                Text(
                  bookingDetails,
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}