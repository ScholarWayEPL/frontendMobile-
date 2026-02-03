import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

/// Modèle de données pour User
/// Responsable de la sérialisation/désérialisation JSON
/// N'hérite PAS de User - utilise la composition
class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? phoneNumber;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.createdAt,
  });

  /// Conversion depuis JSON (API response)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  /// Conversion vers JSON (API request)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    };
  }

  /// Conversion depuis l'entité du domaine
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      phoneNumber: user.phoneNumber,
      createdAt: user.createdAt,
    );
  }

  /// Conversion vers l'entité du domaine
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      createdAt: createdAt,
    );
  }

  /// Copie avec modifications
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, email, name, phoneNumber, createdAt];

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, phoneNumber: $phoneNumber, createdAt: $createdAt)';
  }
}
