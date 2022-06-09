const String tableName = 'user_location_sqflite';

class LocationFields {
  static final List<String> values = [id, cityName];

  static const String id = 'id';
  static const String cityName = 'cityName';
}

class Location {
  final int? id;
  late final String cityName;

  Location({
    this.id,
    required this.cityName,
  });

  Location copy({
    int? id,
    String? cityName,
  }) =>
      Location(id: id ?? this.id, cityName: cityName ?? this.cityName);

  static Location fromJson(Map<String, Object?> json) => Location(
        id: json[LocationFields.id] as int,
        cityName: json[LocationFields.cityName] as String,
      );

  Map<String, Object> toJson() => {
        LocationFields.cityName: cityName,
      };

  @override
  String toString() {
    return 'Location{id: $id, name: $cityName}';
  }
}
