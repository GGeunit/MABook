// class UserModel {
//   late int id;
//   // late String userId;
//   // late String password;
//   late String name;

//   UserModel({required this.id, required this.name});

//   UserModel.parse(Map m) {
//     id = m['id'];
//     name = m['name'];
//     // userId = m['userId'];
//     // password = m['password'];
//   }
// }

// class UserModel {
//   final int id;
//   final String name;

//   UserModel({required this.id, required this.name});

//   factory UserModel.parse(Map<dynamic, dynamic> data) {
//     if (data['id'] == null || data['name'] == null) {
//       throw ArgumentError('Invalid user data: $data');
//     }

//     return UserModel(
//       id: data['id'],
//       name: data['name'],
//     );
//   }
// }

class UserModel {
  final int id;
  final String userId; // userId 필드 추가
  final String name;

  UserModel({required this.id, required this.userId, required this.name});

  factory UserModel.parse(Map<dynamic, dynamic> data) {
    if (data['id'] == null || data['name'] == null || data['user_id'] == null) {
      throw ArgumentError('Invalid user data: $data');
    }

    return UserModel(
      id: data['id'],
      userId: data['user_id'], // userId 필드 파싱
      name: data['name'],
    );
  }
}
