class Suggestion{
  final int id;
  final String name;
  final String avt;
    Suggestion({
    required this.id,
    required this.name,
    required this.avt,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      id: json['id'] as int,
      name: json['name'] as String,
      avt: json['avatar'] as String,
    );
  }
}