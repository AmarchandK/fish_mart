import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? email;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.email,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    String? email,
    String? profileImage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phoneNumber,
        name,
        email,
        profileImage,
        createdAt,
        updatedAt,
      ];
}