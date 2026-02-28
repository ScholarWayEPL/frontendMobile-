/// Entité de base pour l'authentification
/// Pure business logic - aucune dépendance externe
class User {
  final String id;
  final String token;
  final String email;
  final String nom;
  final String prenom;
  final String? phoneNumber;
  final String? role;
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.token,
    required this.email,
    required this.nom,
    required this.prenom,
    this.phoneNumber,
    this.role,
    this.createdAt,
  });

  /// Comparaison basée sur les valeurs
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.role == role &&
        other.phoneNumber == phoneNumber &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        token.hashCode ^
        email.hashCode ^
        nom.hashCode ^
        prenom.hashCode ^
        role.hashCode ^
        phoneNumber.hashCode ^
        createdAt.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, token: $token, email: $email, nom: $nom, prenom: $prenom, role: $role, phoneNumber: $phoneNumber, createdAt: $createdAt)';
  }

  /// Copie avec modifications
  User copyWith({
    String? id,
    String? token,
    String? email,
    String? nom,
    String? prenom,
    String? role,
    String? phoneNumber,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
      email: email ?? this.email,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
