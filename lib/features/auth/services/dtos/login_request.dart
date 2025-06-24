class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: $password)';
  }
}
