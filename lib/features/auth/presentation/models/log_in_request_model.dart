class LogInRequestModel {
  final String email;
  final String password;

  LogInRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email' : email,
      'password': password
    };
  }
}
