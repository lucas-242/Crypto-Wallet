import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    this.name = '',
    this.email = '',
    this.photoUrl,
    this.uid = '',
  });

  final String name;
  final String email;
  final String? photoUrl;
  final String uid;

  @override
  List<Object?> get props => [name, email, photoUrl, uid];
}
