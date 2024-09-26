import 'package:flutter/material.dart';
import 'second_component.dart';

/// FirstComponent shows a button that navigates to the SecondComponent.
class FirstComponent extends StatelessWidget {
  const FirstComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Component'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SecondComponent(),
              ),
            );
          },
          child: const Text('I am next'),
        ),
      ),
    );
  }
}
