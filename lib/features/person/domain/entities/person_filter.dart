class PersonFilter {
  final String name;
  PersonFilter({this.name = ''});

  Map<String, dynamic> toJson(PersonFilter filter) {
    return {'name': filter.name};
  }
}
