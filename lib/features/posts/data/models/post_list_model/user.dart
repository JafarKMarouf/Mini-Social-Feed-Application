import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;

  const User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    name: json['name'] as String?,
    email: json['email'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};

  @override
  List<Object?> get props => [id, name, email];
}
