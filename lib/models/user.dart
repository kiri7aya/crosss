class User {
  final String firstName;
  final String lastName;
  final String profileImageUrl;
  final bool darkMode;
  String biography;  // Сделаем это поле изменяемым

  User({
    required this.firstName,
    required this.lastName,
    required this.profileImageUrl,
    required this.darkMode,
    this.biography = "",  // По умолчанию пустая биография
  });
}
