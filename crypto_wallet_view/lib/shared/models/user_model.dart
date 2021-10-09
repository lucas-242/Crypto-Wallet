import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String? photoUrl;
  final String uid;

  UserModel({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.uid,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? photoUrl,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, email: $email, photoUrl: $photoUrl, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ photoUrl.hashCode ^ uid.hashCode;
  }
}
