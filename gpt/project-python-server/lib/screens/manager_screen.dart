import 'package:flutter/material.dart';
import 'package:border_queue_management_app/services/manager_service.dart';

class ManagerScreen extends StatefulWidget {
  @override
  _ManagerScreenState createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  final _capacityController = TextEditingController();
  int _currentCapacity;

  @override
  void initState() {
    super.initState();
    _loadCurrentCapacity();
  }

  void _loadCurrentCapacity() async {
    int capacity = await ManagerService().getCurrentCapacity();
    setState(() {
      _currentCapacity = capacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Border Manager Interface'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _capacityController,
              decoration: InputDecoration(labelText: 'Set Capacity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int newCapacity = int.parse(_capacityController.text);
                ManagerService().setCapacity(newCapacity);
                _loadCurrentCapacity();
              },
              child: Text('Update Capacity'),
            ),
            SizedBox(height: 20),
            Text('Current Capacity: $_currentCapacity'),
          ],
        ),
      ),
    );
  }
}