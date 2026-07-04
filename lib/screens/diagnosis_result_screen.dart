import 'package:flutter/material.dart';
import '../config/app_theme.dart';

/// Diagnosis result screen (placeholder - will be implemented in Task 9)
class DiagnosisResultScreen extends StatelessWidget {
  final String imagePath;

  const DiagnosisResultScreen({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Diagnosis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.biotech,
              size: 80,
              color: AppTheme.primaryGreen,
            ),
            const SizedBox(height: 24),
            Text(
              'Diagnosis Result Screen',
              style: AppTheme.headingMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Coming Soon in Task 9',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textLight,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Image: $imagePath',
              style: AppTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
