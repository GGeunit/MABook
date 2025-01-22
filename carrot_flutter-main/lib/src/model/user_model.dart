class UserModel {
  late int id;
  late String userId;
  late String password;
  late String name;

  UserModel({required this.id, required this.name});

  UserModel.parse(Map m) {
    id = m['id'];
    name = m['name'];
    userId = m['userId'];
    password = m['password'];
  }
}
