class Episode {
  final int id;
  final String name;
  final int season;
  final String? imageUrl;
  final String summary;

  Episode(
      {required this.id,
      this.name = '',
      required this.season,
      this.imageUrl,
      this.summary = ''});

  factory Episode.fromJson(Map<String, dynamic> json) {
    final image = json["image"] ?? {};
    return Episode(
        id: int.parse(json['id'].toString()),
        name: json['name'],
        season: int.parse(json['season'].toString()),
        imageUrl: image['medium'],
        summary: json['summary']);
  }
}
