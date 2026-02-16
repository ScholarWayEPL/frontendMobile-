class OnboardingFeature {
  final String number;
  final String icon;
  final String title;
  final String description;
  final String? imageUrl;

  OnboardingFeature({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingFeature &&
          runtimeType == other.runtimeType &&
          number == other.number &&
          icon == other.icon &&
          title == other.title &&
          description == other.description &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      number.hashCode ^
      icon.hashCode ^
      title.hashCode ^
      description.hashCode ^
      imageUrl.hashCode;

  OnboardingFeature copyWith({
    String? number,
    String? icon,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return OnboardingFeature(
      number: number ?? this.number,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
