class ShowItem {
  final int id;
  final String name;
  final List<String> genres;
  final String scheduleTime;
  final List<String> scheduleDays;
  final String? imageUrl;
  final String summary;

  ShowItem(
      {required this.id,
      required this.name,
      this.genres = const [],
      this.scheduleTime = '',
      this.scheduleDays = const [],
      this.imageUrl,
      this.summary = ''});

  factory ShowItem.fromJson(Map<String, dynamic> json) {
    final show = json["show"] ?? {};
    final image = show["image"] ?? {};
    final schedule = show['schedule'] ?? {};
    return ShowItem(
        id: show['id'],
        name: show['name'] ?? '',
        genres: (show['genres'] ?? []).cast<String>(),
        scheduleTime: schedule['time'] ?? '',
        scheduleDays: (schedule['days'] ?? []).cast<String>(),
        imageUrl: image['medium'] ?? '',
        summary: show['summary'] ?? '');
  }

  factory ShowItem.fromJsonItem(Map<String, dynamic> json) {
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
  }
}
