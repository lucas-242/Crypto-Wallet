import 'dart:convert';

class User {
  final String name;
  final String email;
  final String? photoUrl;
  final String uid;

  User({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.uid,
  });

  User copyWith({
    String? name,
    String? email,
    String? photoUrl,
    String? uid,
  }) {
    return User(
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, email: $email, photoUrl: $photoUrl, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
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
