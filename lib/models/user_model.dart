class UserModel {
  final String id;
  final String accessToken;
  final String refreshToken;
  final String userName;
  final String email;
  final String password;
  final String? firstName;
  final String? lastName;
  final String? gender;

  UserModel({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.userName,
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
    this.gender,
  });
}
