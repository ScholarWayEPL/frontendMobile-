import 'package:flutter/material.dart';

/// Couleurs extraites rigoureusement des maquettes
class AuthColors {
  // --- Fonds ---
  static const Color background = Color(
    0xFF091A16,
  ); // Fond de page principal (quasi-noir verdâtre)
  static const Color cardBackground = Color(
    0xFF0F2421,
  ); // Fond des cartes / formulaires
  static const Color fieldBackground = Color.fromARGB(
    255,
    11,
    20,
    22,
  ); // Fond des champs de saisie
  static const Color fieldBorder = Color(
    0xFF1A3832,
  ); // Bordure subtile des champs et cartes

  // --- Accents ---
  static const Color accent = Color.fromARGB(
    255,
    6,
    78,
    59,
  ); // Vert émeraude vif (liens, onglet actif, textes accentués)
  static const Color buttonGreen = Color(
    0xFF0E8C6A,
  ); // Teal profond (boutons CTA uniquement)

  // --- Or / Labels ---
  static const Color gold = Color(
    0xFFB8A992,
  ); // Doré (labels de section en majuscules)
  static const Color goldLight = Color(0xFFD4C5A9); // Doré clair

  // --- Blancs ---
  static const Color white = Colors.white;
  static const Color white70 = Color(0xB3FFFFFF); // Texte secondaire
  static const Color white50 = Color(0x80FFFFFF); // Texte tertiaire
  static const Color white40 = Color(
    0x66FFFFFF,
  ); // Texte discret / placeholders
  static const Color white20 = Color(0x33FFFFFF); // Très discret

  // --- Couleurs thématiques ---
  static const Color selectedTint = Color(
    0xFF0D3D2F,
  ); // Fond des éléments sélectionnés
  static const Color barGold = Color(
    0xFFC4A96A,
  ); // Barres de progression dorées
  static const Color barTeal = Color(0xFF3A6B5D); // Barres secondaires
}
