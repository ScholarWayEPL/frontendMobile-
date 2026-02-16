class Partner {
  final String name;
  final String logoUrl;

  Partner({required this.name, required this.logoUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Partner &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          logoUrl == other.logoUrl;

  @override
  int get hashCode => name.hashCode ^ logoUrl.hashCode;

  Partner copyWith({String? name, String? logoUrl}) {
    return Partner(name: name ?? this.name, logoUrl: logoUrl ?? this.logoUrl);
  }
}
