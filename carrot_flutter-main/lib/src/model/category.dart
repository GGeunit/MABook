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
<<<<<<< HEAD

}
=======
}
>>>>>>> cb14c44f45d442c68ffb7a5f007fcddf52603efe
