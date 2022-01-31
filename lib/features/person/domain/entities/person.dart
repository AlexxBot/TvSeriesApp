class Person {
  final int id;
  final String name;
  final String? imageUrl;

  Person({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    final person = json["person"] ?? {};
    final image = person["image"] ?? {};
    return Person(
        id: person['id'],
        name: person['name'] ?? '',
        imageUrl: image['original'] ?? '');
  }

  /* factory Person.fromJsonItem(Map<String, dynamic> json) {
    final image = json["image"] ?? {};
    final schedule = json['schedule'] ?? {};
    return ShowItem(
        id: json['id'],
        name: json['name'] ?? '',
        genres: (json['genres'] ?? []).cast<String>(),
        scheduleTime: schedule['time'] ?? '',
        scheduleDays: (schedule['days'] ?? []).cast<String>(),
        imageUrl: image['medium'] ?? '',
        summary: json['summary'] ?? '');
  } */
}
