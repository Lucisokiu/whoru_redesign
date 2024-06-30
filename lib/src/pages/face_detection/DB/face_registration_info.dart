class FaceRegistrationInfo {
  final int id;
  final List<double> embedding;

  FaceRegistrationInfo({
    required this.id,
    required this.embedding,
  });
  factory FaceRegistrationInfo.fromJson(Map<String, dynamic> json) {
    return FaceRegistrationInfo(
      id: json['userId'] as int,
      embedding:
          (json['embedding'] as List<dynamic>).map((e) => e as double).toList(),
    );
  }
}
