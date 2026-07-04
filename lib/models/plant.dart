import 'plant_diagnosis.dart';

/// Model for a plant in the user's collection
class Plant {
  final String id;
  final String name;
  final String? nickname; // Custom name given by user
  final String? species;
  final String imagePath;
  final DateTime addedDate;
  final DateTime lastCheckDate;
  final List<PlantDiagnosis> diagnosisHistory;
  final String currentHealthStatus; // healthy, mild, moderate, severe
  final String? notes;

  Plant({
    required this.id,
    required this.name,
    this.nickname,
    this.species,
    required this.imagePath,
    required this.addedDate,
    required this.lastCheckDate,
    this.diagnosisHistory = const [],
    required this.currentHealthStatus,
    this.notes,
  });

  // Factory constructor to create from JSON
  factory Plant.fromJson(Map<String, dynamic> json) {
    final diagnosisHistoryData = json['diagnosisHistory'] as List<dynamic>? ?? [];
    final diagnosisHistory = diagnosisHistoryData
        .map((e) => PlantDiagnosis.fromJson(e as Map<String, dynamic>))
        .toList();

    return Plant(
      id: json['id'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String?,
      species: json['species'] as String?,
      imagePath: json['imagePath'] as String,
      addedDate: DateTime.parse(json['addedDate'] as String),
      lastCheckDate: DateTime.parse(json['lastCheckDate'] as String),
      diagnosisHistory: diagnosisHistory,
      currentHealthStatus: json['currentHealthStatus'] as String,
      notes: json['notes'] as String?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'species': species,
      'imagePath': imagePath,
      'addedDate': addedDate.toIso8601String(),
      'lastCheckDate': lastCheckDate.toIso8601String(),
      'diagnosisHistory': diagnosisHistory.map((d) => d.toJson()).toList(),
      'currentHealthStatus': currentHealthStatus,
      'notes': notes,
    };
  }

  // Factory constructor to create from initial diagnosis
  factory Plant.fromDiagnosis(PlantDiagnosis diagnosis, {String? nickname}) {
    return Plant(
      id: diagnosis.id,
      name: diagnosis.commonName.isNotEmpty 
          ? diagnosis.commonName 
          : diagnosis.diseaseName,
      nickname: nickname,
      species: diagnosis.commonName,
      imagePath: diagnosis.imagePath,
      addedDate: diagnosis.diagnosisDate,
      lastCheckDate: diagnosis.diagnosisDate,
      diagnosisHistory: [diagnosis],
      currentHealthStatus: diagnosis.severity,
      notes: null,
    );
  }

  // Get the most recent diagnosis
  PlantDiagnosis? get latestDiagnosis {
    if (diagnosisHistory.isEmpty) return null;
    return diagnosisHistory.reduce(
      (a, b) => a.diagnosisDate.isAfter(b.diagnosisDate) ? a : b,
    );
  }

  // Get diagnosis count
  int get diagnosisCount => diagnosisHistory.length;

  // Check if plant is healthy
  bool get isHealthy => currentHealthStatus == 'healthy';

  // Get health status color indicator
  String get healthStatusEmoji {
    switch (currentHealthStatus) {
      case 'healthy':
        return '✅';
      case 'mild':
        return '⚠️';
      case 'moderate':
        return '🟠';
      case 'severe':
        return '🔴';
      default:
        return '❓';
    }
  }

  // Get health status text in Indonesian
  String get healthStatusText {
    switch (currentHealthStatus) {
      case 'healthy':
        return 'Sehat';
      case 'mild':
        return 'Ringan';
      case 'moderate':
        return 'Sedang';
      case 'severe':
        return 'Parah';
      default:
        return 'Tidak Diketahui';
    }
  }

  // Get display name (nickname if available, otherwise name)
  String get displayName => nickname?.isNotEmpty == true ? nickname! : name;

  // Create a copy with modified fields
  Plant copyWith({
    String? id,
    String? name,
    String? nickname,
    String? species,
    String? imagePath,
    DateTime? addedDate,
    DateTime? lastCheckDate,
    List<PlantDiagnosis>? diagnosisHistory,
    String? currentHealthStatus,
    String? notes,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      species: species ?? this.species,
      imagePath: imagePath ?? this.imagePath,
      addedDate: addedDate ?? this.addedDate,
      lastCheckDate: lastCheckDate ?? this.lastCheckDate,
      diagnosisHistory: diagnosisHistory ?? this.diagnosisHistory,
      currentHealthStatus: currentHealthStatus ?? this.currentHealthStatus,
      notes: notes ?? this.notes,
    );
  }

  // Add a new diagnosis to history
  Plant addDiagnosis(PlantDiagnosis diagnosis) {
    final updatedHistory = [...diagnosisHistory, diagnosis];
    return copyWith(
      diagnosisHistory: updatedHistory,
      lastCheckDate: diagnosis.diagnosisDate,
      currentHealthStatus: diagnosis.severity,
    );
  }

  @override
  String toString() {
    return 'Plant(id: $id, name: $name, status: $currentHealthStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Plant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
