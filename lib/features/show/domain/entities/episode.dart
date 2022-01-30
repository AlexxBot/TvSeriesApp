class Episode {
  final int id;
  final String name;
  final int season;
  final int number;
  final String? imageUrl;
  final String summary;

  Episode(
      {required this.id,
      this.name = '',
      required this.season,
      required this.number,
      this.imageUrl,
      this.summary = ''});

  factory Episode.fromJson(Map<String, dynamic> json) {
    final image = json["image"] ?? {};
    return Episode(
        id: int.parse(json['id'].toString()),
        name: json['name'] ?? '',
        season: int.parse(json['season'].toString()),
        number: int.parse(json['number'].toString()),
        imageUrl: image['medium'],
        summary: json['summary'] ?? '');
  }
}
