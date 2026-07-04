import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../config/app_theme.dart';
import '../utils/logger.dart';
import 'diagnosis_result_screen.dart';

/// Camera screen with guideline overlay for capturing plant images
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview placeholder with guideline
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Guideline frame
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.accentYellow,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      // Corner markers
                      _buildCornerMarker(Alignment.topLeft),
                      _buildCornerMarker(Alignment.topRight),
                      _buildCornerMarker(Alignment.bottomLeft),
                      _buildCornerMarker(Alignment.bottomRight),
                      
                      // Center crosshair
                      Center(
                        child: Icon(
                          Icons.center_focus_weak,
                          size: 60,
                          color: AppTheme.accentYellow.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Instructions
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Posisikan daun tanaman di dalam bingkai',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pastikan pencahayaan cukup dan fokus jelas',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Top bar with back button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Scan Tanaman',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48), // Balance back button
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Gallery button
                    _buildControlButton(
                      icon: Icons.photo_library,
                      label: 'Galeri',
                      onPressed: _isProcessing ? null : _pickFromGallery,
                    ),
                    
                    // Capture button
                    _buildCaptureButton(),
                    
                    // Flash button (placeholder)
                    _buildControlButton(
                      icon: Icons.flash_off,
                      label: 'Flash',
                      onPressed: () {
                        // TODO: Toggle flash
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Loading overlay
          if (_isProcessing)
            Container(
              color: Colors.black.withValues(alpha: 0.7),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Memproses gambar...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCornerMarker(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            top: alignment.y < 0
                ? BorderSide(color: AppTheme.accentYellow, width: 4)
                : BorderSide.none,
            bottom: alignment.y > 0
                ? BorderSide(color: AppTheme.accentYellow, width: 4)
                : BorderSide.none,
            left: alignment.x < 0
                ? BorderSide(color: AppTheme.accentYellow, width: 4)
                : BorderSide.none,
            right: alignment.x > 0
                ? BorderSide(color: AppTheme.accentYellow, width: 4)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCaptureButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryGreen,
              width: 4,
            ),
          ),
          child: IconButton(
            onPressed: _isProcessing ? null : _captureFromCamera,
            icon: const Icon(
              Icons.camera_alt,
              color: AppTheme.primaryGreen,
              size: 36,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ambil Foto',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Future<void> _captureFromCamera() async {
    try {
      setState(() {
        _isProcessing = true;
      });

      Logger.info('Capturing image from camera', tag: 'CameraScreen');

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null && mounted) {
        Logger.info('Image captured: ${image.path}', tag: 'CameraScreen');
        _navigateToDiagnosisResult(image.path);
      } else {
        setState(() {
          _isProcessing = false;
        });
      }
    } catch (e) {
      Logger.error('Error capturing image', tag: 'CameraScreen', error: e);
      setState(() {
        _isProcessing = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil foto: $e'),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      setState(() {
        _isProcessing = true;
      });

      Logger.info('Picking image from gallery', tag: 'CameraScreen');

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null && mounted) {
        Logger.info('Image selected: ${image.path}', tag: 'CameraScreen');
        _navigateToDiagnosisResult(image.path);
      } else {
        setState(() {
          _isProcessing = false;
        });
      }
    } catch (e) {
      Logger.error('Error picking image', tag: 'CameraScreen', error: e);
      setState(() {
        _isProcessing = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih gambar: $e'),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    }
  }

  void _navigateToDiagnosisResult(String imagePath) {
    // Navigate to diagnosis result screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DiagnosisResultScreen(
          imagePath: imagePath,
        ),
      ),
    );
  }
}
