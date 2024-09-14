import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql_client.dart';

class BorderManagerScreen extends StatefulWidget {
  @override
  _BorderManagerScreenState createState() => _BorderManagerScreenState();
}

class _BorderManagerScreenState extends State<BorderManagerScreen> {
  final _formKey = GlobalKey<FormState>();
  String orderNumber = '';
  int capacityCount = 0;
  String resultMessage = '';

  void _processBooking() async {
    final client = GraphQLConfig.clientToQuery();
    final String processBookingMutation = """
      mutation ProcessBooking(\$orderNumber: Int!, \$capacityCount: Int!) {
        processBooking(orderNumber: \$orderNumber, capacityCount: \$capacityCount)
      }
    """;

    final result = await client.mutate(
      MutationOptions(
        document: gql(processBookingMutation),
        variables: {
          'orderNumber': int.parse(orderNumber),
          'capacityCount': capacityCount,
        },
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
    } else {
      setState(() {
        resultMessage = result.data['processBooking'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Border Manager Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Order Number'),
                onChanged: (value) {
                  setState(() {
                    orderNumber = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Capacity Count'),
                onChanged: (value) {
                  setState(() {
                    capacityCount = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _processBooking,
                child: Text('Process Booking'),
              ),
              SizedBox(height: 20),
              if (resultMessage.isNotEmpty)
                Text(
                  resultMessage,
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}