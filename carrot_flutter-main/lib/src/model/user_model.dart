class UserModel {
<<<<<<< HEAD
    late int id;
  late String userId;
  late String password;
  late String name;
  
      
=======
  late int id;
  late String userId;
  late String password;
  late String name;

>>>>>>> cb14c44f45d442c68ffb7a5f007fcddf52603efe
  UserModel({required this.id, required this.name});

  UserModel.parse(Map m) {
    id = m['id'];
    name = m['name'];
    userId = m['userId'];
    password = m['password'];
  }
}
