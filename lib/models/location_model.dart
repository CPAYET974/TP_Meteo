const String tableName = 'user_location_sqflite';

class Location {
  final int id;
  final String cityName;

  const Location({
    required this.id,
    required this.cityName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cityName': cityName,
    };
  }

  @override
  String toString() {
    return 'Location{id: $id, name: $cityName}';
  }
}
