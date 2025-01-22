class CategoryModel {
  late int id;
  late String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  CategoryModel.parse(Map m) {
    id = m['id'];
    name = m['name'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
