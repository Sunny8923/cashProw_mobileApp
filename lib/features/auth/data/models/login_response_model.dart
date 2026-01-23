import 'user_model.dart';

class LoginResponseModel {
  final String message;
  final String token;
  final UserModel user;

  LoginResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final userJson = json["data"];

    if (userJson is! Map<String, dynamic>) {
      throw Exception("Invalid login response: user data missing");
    }

    return LoginResponseModel(
      message: json["message"]?.toString() ?? "",
      token: json["token"]?.toString() ?? "",
      user: UserModel.fromJson(userJson),
    );
  }
}
