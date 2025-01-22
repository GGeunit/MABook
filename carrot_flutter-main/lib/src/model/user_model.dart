class UserModel {
  late int id;
  late String name;

  UserModel({required this.id, required this.name});

  UserModel.parse(Map m) {
    id = m['id'];
    name = m['name'];
  }
}
