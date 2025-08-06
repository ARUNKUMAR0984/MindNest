import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: const Text(
        "© 2025 Ak MindNest Studio | Built with Flutter Web",
        textAlign: TextAlign.center,
      ),
    );
  }
}