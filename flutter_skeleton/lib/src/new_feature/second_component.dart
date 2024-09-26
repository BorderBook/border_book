import 'package:flutter/material.dart';

/// SecondComponent shows payment and Smart ID sign-in options.
class SecondComponent extends StatelessWidget {
  const SecondComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Component'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                // Implement Pay 1 EUR logic here
              },
              child: const Text('Pay 1 EUR'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign in with Smart ID and get your ticket for free',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Implement Smart ID sign-in logic here
                  },
                  child: const Text('Sign in with SmartID'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
