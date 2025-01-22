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

}