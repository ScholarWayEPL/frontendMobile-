import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

/// Modèle de données pour User
/// Responsable de la sérialisation/désérialisation JSON
/// N'hérite PAS de User - utilise la composition
class UserModel extends Equatable {
  final String id;
  final String token;
  final String email;
  final String nom;
  final String prenom;
  final String? phoneNumber;
  final String? role;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.token,
    required this.email,
    required this.nom,
    required this.prenom,
    this.phoneNumber,
    this.role,
    this.createdAt,
  });

  /// Conversion depuis JSON (API response)
  /// Gère les différentes structures de réponse selon le rôle:
  /// - ROLE_BACHELIER: inclut un objet 'bachelier' avec les détails
  /// - ROLE_ETABLISSEMENT: inclut un objet 'etablissement' avec les détails
  /// - ROLE_ADMINISTRATEUR: pas d'objet imbriqué
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // If the json contains a 'data' key, we might be receiving the whole response
    final data =
        json.containsKey('data') && json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final role = data['role']?.toString() ?? data['roles']?.toString();
    
    // Extraction du téléphone et prénom selon le rôle
    String? phoneNumber;
    String prenom = '';
    String nom = (data['nom'] ?? '').toString();
    
    if (role == 'ROLE_BACHELIER' && data['bachelier'] is Map<String, dynamic>) {
      final bachelier = data['bachelier'] as Map<String, dynamic>;
      phoneNumber = bachelier['telephone']?.toString();
      prenom = (data['prenom'] ?? bachelier['prenom'] ?? '').toString();
      // Le nom peut aussi venir du bachelier
      if (nom.isEmpty) {
        nom = (bachelier['nom'] ?? '').toString();
      }
    } else if (role == 'ROLE_ETABLISSEMENT' && data['etablissement'] is Map<String, dynamic>) {
      final etablissement = data['etablissement'] as Map<String, dynamic>;
      phoneNumber = etablissement['telephonePro']?.toString();
      // Pour un établissement, le nom est nomEtablissement
      if (nom.isEmpty) {
        nom = (etablissement['nomEtablissement'] ?? '').toString();
      }
      // Pas de prénom pour un établissement
      prenom = '';
    } else {
      // Pour l'admin ou autres, pas d'objet imbriqué
      prenom = (data['prenom'] ?? '').toString();
      phoneNumber = data['phoneNumber']?.toString();
    }

    return UserModel(
      id: (data['id'] ?? data['userId'] ?? '').toString(),
      token: (data['token'] ?? '').toString(),
      email: (data['email'] ?? '').toString(),
      nom: nom,
      prenom: prenom,
      phoneNumber: phoneNumber,
      role: role,
      createdAt: data['createdAt'] != null
          ? DateTime.tryParse(data['createdAt'].toString())
          : (data['expiresAt'] != null
                ? DateTime.tryParse(data['expiresAt'].toString())
                : null),
    );
  }

  /// Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'phoneNumber': phoneNumber,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  /// Conversion depuis l'entité du domaine
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      token: user.token,
      email: user.email,
      nom: user.nom,
      prenom: user.prenom,
      phoneNumber: user.phoneNumber,
      role: user.role,
      createdAt: user.createdAt,
    );
  }

  /// Conversion vers l'entité du domaine
  User toEntity() {
    return User(
      id: id,
      token: token,
      email: email,
      nom: nom,
      prenom: prenom,
      phoneNumber: phoneNumber,
      role: role,
      createdAt: createdAt,
    );
  }

  /// Copie avec modifications
  UserModel copyWith({
    String? id,
    String? token,
    String? email,
    String? nom,
    String? prenom,
    String? phoneNumber,
    String? role,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      token: token ?? this.token,
      email: email ?? this.email,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    token,
    email,
    nom,
    prenom,
    phoneNumber,
    role,
    createdAt,
  ];

  @override
  String toString() {
    return 'UserModel(id: $id, token: $token, email: $email, nom: $nom, prenom: $prenom, role: $role, phoneNumber: $phoneNumber, createdAt: $createdAt)';
  }
}
