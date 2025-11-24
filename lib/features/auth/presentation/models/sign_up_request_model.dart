class SignUpRequestModel {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String city;
  final String phone;

  SignUpRequestModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.city,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstname,
      "last_name": lastname,
      "email": email,
      "password": password,
      "phone": phone,
      "city": city,
    };
  }
}
