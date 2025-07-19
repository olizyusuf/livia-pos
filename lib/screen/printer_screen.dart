import 'package:flutter/material.dart';

class PrinterScreen extends StatelessWidget {
  const PrinterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printer'),
      ),
      body: const Center(
        child: Text('Printer Screen'),
      ),
    );
  }
}
