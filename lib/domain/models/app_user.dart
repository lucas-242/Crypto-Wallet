import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
final class AppUser extends Equatable {
  const AppUser({
    this.name = '',
    this.email = '',
    this.photoUrl,
    this.uid = '',
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  final String name;
  final String email;
  final String? photoUrl;
  final String uid;

  @override
  List<Object?> get props => [name, email, photoUrl, uid];
}
