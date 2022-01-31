class ShowFilter {
  final String name;
  ShowFilter({this.name = ''});

  Map<String, dynamic> toJson(ShowFilter filter) {
    return {'name': filter.name};
  }
}
