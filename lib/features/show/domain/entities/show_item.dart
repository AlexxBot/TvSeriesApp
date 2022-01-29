class ShowItem {
  final int id;
  final String name;
  final String? imageUrl;

  ShowItem({required this.id, required this.name, this.imageUrl});

  factory ShowItem.fromJson(Map<String, dynamic> json) {
    final show = json["show"] ?? {};
    final image = show["image"] ?? {};
    return ShowItem(
        id: show['id'],
        name: show['name'] ?? '',
        imageUrl: image['medium'] ?? '');
  }
}
