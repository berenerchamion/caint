import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottomOpacity: 0.5,
        title: const Text('Ag caint i nGleann Comhann'),
      ),
      body: Center(
        child: const Text('A catastrophic error has happened.'),
      ),
    );
  }
}
