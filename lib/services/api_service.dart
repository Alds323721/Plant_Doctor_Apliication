import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import '../config/app_constants.dart';
import '../utils/logger.dart';

/// Service for communicating with Plant Disease Detection API
class ApiService {
  static ApiService? _instance;
  final http.Client _client;
  final String _apiKey;
  final String _baseUrl;

  // Private constructor
  ApiService._({
    http.Client? client,
    String? apiKey,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _apiKey = apiKey ?? AppConstants.apiKey,
        _baseUrl = baseUrl ?? AppConstants.apiBaseUrl;

  // Singleton instance
  static ApiService get instance {
    _instance ??= ApiService._();
    return _instance!;
  }

  // For testing purposes
  static void setInstance(ApiService instance) {
    _instance = instance;
  }

  /// Diagnose plant disease from image file
  Future<PlantDiagnosis> diagnosePlant(String imagePath) async {
    try {
      Logger.info('Starting plant diagnosis for: $imagePath', tag: 'ApiService');

      // Read image file
      final imageFile = File(imagePath);
      if (!await imageFile.exists()) {
        throw Exception('Image file not found: $imagePath');
      }

      // Read image bytes and convert to base64
      final imageBytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      // Generate unique diagnosis ID
      final diagnosisId = const Uuid().v4();

      // Call API
      final response = await _callHealthAssessmentApi(base64Image);

      // Parse response
      final diagnosis = PlantDiagnosis.fromApiResponse(
        response,
        imagePath,
        diagnosisId,
      );

      Logger.info(
        'Diagnosis completed: ${diagnosis.diseaseName} (${(diagnosis.accuracy * 100).toStringAsFixed(1)}%)',
        tag: 'ApiService',
      );

      return diagnosis;
    } catch (e) {
      Logger.error('Error diagnosing plant', tag: 'ApiService', error: e);
      rethrow;
    }
  }

  /// Call Plant.id Health Assessment API
  Future<Map<String, dynamic>> _callHealthAssessmentApi(String base64Image) async {
    try {
      // Check if API key is configured
      if (_apiKey == 'YOUR_API_KEY_HERE' || _apiKey.isEmpty) {
        Logger.warning('API key not configured, using mock data', tag: 'ApiService');
        return _getMockResponse();
      }

      final url = Uri.parse('$_baseUrl/health_assessment');
      
      final requestBody = {
        'images': [base64Image],
        'latitude': -6.2088, // Default Jakarta coordinates
        'longitude': 106.8456,
        'similar_images': true,
      };

      Logger.info('Calling Plant.id API: $url', tag: 'ApiService');

      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Api-Key': _apiKey,
        },
        body: jsonEncode(requestBody),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('API request timed out after 30 seconds');
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        Logger.info('API call successful', tag: 'ApiService');
        return jsonResponse;
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your configuration.');
      } else if (response.statusCode == 429) {
        throw Exception('API rate limit exceeded. Please try again later.');
      } else {
        Logger.error(
          'API error: ${response.statusCode}',
          tag: 'ApiService',
          error: response.body,
        );
        throw Exception('API error: ${response.statusCode} - ${response.body}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } on TimeoutException {
      throw Exception('Connection timeout. Please check your internet connection.');
    } on FormatException {
      throw Exception('Invalid response format from server.');
    } catch (e) {
      Logger.error('API call failed', tag: 'ApiService', error: e);
      rethrow;
    }
  }

  /// Get mock response for testing/demo purposes
  Map<String, dynamic> _getMockResponse() {
    // Simulate API delay
    Logger.info('Returning mock diagnosis data', tag: 'ApiService');
    
    // Return mock data that simulates Plant.id API response
    return {
      'health_assessment': {
        'diseases': [
          {
            'name': 'Leaf Spot Disease',
            'probability': 0.85,
            'disease_details': {
              'common_names': ['Bercak Daun'],
              'description':
                  'Penyakit bercak daun adalah infeksi jamur yang menyebabkan bintik-bintik coklat atau hitam pada daun tanaman. Dapat menyebar dengan cepat jika tidak ditangani.',
              'symptoms': [
                'Bintik-bintik coklat atau hitam pada daun',
                'Daun menguning di sekitar bercak',
                'Daun gugur prematur',
                'Pertumbuhan tanaman terhambat',
              ],
              'treatment': {
                'biological': [
                  'Buang daun yang terinfeksi dan musnahkan',
                  'Tingkatkan sirkulasi udara di sekitar tanaman',
                  'Hindari penyiraman dari atas',
                ],
                'chemical': [
                  'Gunakan fungisida berbasis tembaga',
                  'Aplikasikan fungisida sesuai petunjuk',
                  'Ulangi treatment setiap 7-14 hari',
                ],
                'prevention': [
                  'Jaga jarak tanam yang cukup',
                  'Siram di pagi hari agar daun cepat kering',
                  'Gunakan mulsa untuk mencegah percikan tanah',
                  'Rotasi tanaman setiap musim',
                ],
              },
            },
          },
        ],
      },
    };
  }

  /// Alternative: Diagnose with multiple images for better accuracy
  Future<PlantDiagnosis> diagnosePlantMultipleImages(
    List<String> imagePaths,
  ) async {
    try {
      if (imagePaths.isEmpty) {
        throw Exception('No images provided');
      }

      Logger.info(
        'Starting diagnosis with ${imagePaths.length} images',
        tag: 'ApiService',
      );

      // For now, just use the first image
      // In production, you would combine multiple images
      return await diagnosePlant(imagePaths.first);
    } catch (e) {
      Logger.error('Error in multi-image diagnosis', tag: 'ApiService', error: e);
      rethrow;
    }
  }

  /// Check API health/status
  Future<bool> checkApiHealth() async {
    try {
      // Simple ping to check if API is reachable
      final url = Uri.parse(_baseUrl);
      final response = await _client.head(url).timeout(
            const Duration(seconds: 5),
          );
      return response.statusCode < 500;
    } catch (e) {
      Logger.error('API health check failed', tag: 'ApiService', error: e);
      return false;
    }
  }

  /// Dispose resources
  void dispose() {
    _client.close();
  }
}

/// Exception class for API-specific errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  ApiException(this.message, {this.statusCode, this.originalError});

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException: $message (Status: $statusCode)';
    }
    return 'ApiException: $message';
  }
}
