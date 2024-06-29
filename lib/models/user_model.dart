class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({this.id = -1, required this.name, required this.email});

  UserModel copyWith({int? id, String? name, String? email}) {
    return UserModel(
        name: name ?? this.name, id: id ?? this.id, email: email ?? this.email);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map['name'], id: map['id'], email: map['email']);
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'email': email};
}
