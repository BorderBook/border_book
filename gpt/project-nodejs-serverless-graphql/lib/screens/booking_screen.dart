import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../graphql_client.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String birthdate = '';
  String selectedTime = '';
  String qrCodeData = '';

  void _createBooking() async {
    final client = GraphQLConfig.clientToQuery();
    final String createBookingMutation = """
      mutation CreateBooking(\$firstName: String!, \$lastName: String!, \$birthdate: String!, \$selectedTime: String!) {
        createBooking(firstName: \$firstName, lastName: \$lastName, birthdate: \$birthdate, selectedTime: \$selectedTime) {
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

    final result = await client.mutate(
      MutationOptions(
        document: gql(createBookingMutation),
        variables: {
          'firstName': firstName,
          'lastName': lastName,
          'birthdate': birthdate,
          'selectedTime': selectedTime,
        },
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
    } else {
      setState(() {
        qrCodeData = result.data['createBooking']['id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                onChanged: (value) {
                  setState(() {
                    firstName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onChanged: (value) {
                  setState(() {
                    lastName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Birthdate'),
                onChanged: (value) {
                  setState(() {
                    birthdate = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Selected Time'),
                onChanged: (value) {
                  setState(() {
                    selectedTime = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createBooking,
                child: Text('Create Booking'),
              ),
              SizedBox(height: 20),
              if (qrCodeData.isNotEmpty)
                QrImage(
                  data: qrCodeData,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
            ],
          ),
        ),
      ),
    );
  }
}