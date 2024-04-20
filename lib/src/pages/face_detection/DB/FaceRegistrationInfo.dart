class FaceRegistrationInfo {
  final String number;
  final String name;
  final String surname;
  final List<double> embedding;

  FaceRegistrationInfo({
    required this.number,
    required this.name,
    required this.surname,
    required this.embedding,
  });
}