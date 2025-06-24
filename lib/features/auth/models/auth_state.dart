enum AuthMode { login, register }

class AuthState {
  final String? email;
  final String? password;
  final String? username;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isUsernameValid;
  final AuthMode authMode;
  final bool isLoading;
  final String? errorMessage;

  AuthState({
    this.email,
    this.password,
    this.username,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isUsernameValid = false,
    this.authMode = AuthMode.login,
    this.isLoading = false,
    this.errorMessage,
  });

  AuthState copyWith({
    String? email,
    String? password,
    String? username,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isUsernameValid,
    AuthMode? authMode,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      authMode: authMode ?? this.authMode,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  AuthState initial() {
    return AuthState(
      email: null,
      password: null,
      username: null,
      isEmailValid: false,
      isPasswordValid: false,
      isUsernameValid: false,
      authMode: AuthMode.login,
      isLoading: false,
      errorMessage: null,
    );
  }
}
