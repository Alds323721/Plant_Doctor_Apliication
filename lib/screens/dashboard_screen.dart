import 'package:flutter/material.dart';
import '../config/app_theme.dart';

/// Main dashboard screen (placeholder - will be implemented in Task 7)
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Doctor'),
      ),
      body: const Center(
        child: Text(
          'Dashboard (Coming Soon)',
          style: AppTheme.headingMedium,
        ),
      ),
    );
  }
}
