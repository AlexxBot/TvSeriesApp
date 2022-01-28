class ShowItem {
  final String name;
  final String? imageUrl;

  ShowItem({required this.name, this.imageUrl});

  factory ShowItem.fromJson(Map<String, dynamic> json) {
    return ShowItem(
        name: json['show']['name'], imageUrl: json['show']['image']['medium']);
  }
}
