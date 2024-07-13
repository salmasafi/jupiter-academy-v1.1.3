/* class LoginModel {
  String token;
  String expiryDate;
  String username;
  String userId;
  String role;

  LoginModel({
    required this.token,
    required this.expiryDate,
    required this.username,
    required this.userId,
    required this.role,
  });

  factory LoginModel.fromJson(json) {
    return LoginModel(
      token: json['token'],
      expiryDate: json['expiryDate'],
      username: json['username'],
      userId: json['user_id'],
      role: json['role'],
    );
  }
} */