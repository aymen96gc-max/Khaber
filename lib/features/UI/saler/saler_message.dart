import 'package:flutter/material.dart';

class SalerMessageScreen extends StatelessWidget {
  const SalerMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saler Messages')),
      body: const Center(child: Text('This is the Saler Messages Screen')),
    );
  }
}
