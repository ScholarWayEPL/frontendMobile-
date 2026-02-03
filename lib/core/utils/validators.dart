/// Classe utilitaire pour les validations courantes
class Validators {
  /// Validation d'email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validation de mot de passe (minimum 8 caractères)
  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  /// Validation de numéro de téléphone
  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    return phoneRegex.hasMatch(phone);
  }

  /// Vérifie si une chaîne est vide ou nulle
  static bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }
}
