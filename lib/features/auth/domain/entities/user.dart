/// Entité de base pour l'authentification
/// Pure business logic - aucune dépendance externe
class User {
  final String id;
  final String email;
  final String name;
  final String? phoneNumber;
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.createdAt,
  });

  /// Comparaison basée sur les valeurs
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        createdAt.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, phoneNumber: $phoneNumber, createdAt: $createdAt)';
  }

  /// Copie avec modifications
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
