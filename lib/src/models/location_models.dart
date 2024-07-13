class UserLocation {
  final double latitude;
  final double longitude;
  final int userId;
  final String avt;
  final String? note;
  final String name;

  UserLocation({
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.avt,
    required this.name,
    this.note,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      userId: json['userId'],
      avt: json['avt'],
      name: json['name'],
      note: json['note'],
    );
  }
}
