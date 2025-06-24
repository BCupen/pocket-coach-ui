import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_coach_ui/features/auth/models/auth_state.dart';
import 'package:pocket_coach_ui/features/auth/services/auth_service.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthViewModel(this._authService) : super(AuthState());

  // Update email and validate it
  void setEmail(String email) {
    final isValid = _validateEmail(email);
    state = state.copyWith(email: email, isEmailValid: isValid);
  }

  // Update password and validate it
  void setPassword(String password) {
    final isValid = _validatePassword(password);
    state = state.copyWith(password: password, isPasswordValid: isValid);
  }

  // Update username and validate it (only for register)
  void setUsername(String username) {
    final isValid = _validateUsername(username);
    state = state.copyWith(username: username, isUsernameValid: isValid);
  }

  // Switch between login and register modes
  void toggleAuthMode() {
    final newMode = state.authMode == AuthMode.login
        ? AuthMode.register
        : AuthMode.login;
    state = state.copyWith(authMode: newMode, errorMessage: null);
  }

  // Login action
  Future<void> login() async {
    if (!state.isEmailValid || !state.isPasswordValid) {
      state = state.copyWith(
        errorMessage: "Please enter valid email and password",
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _authService.login(state.email!, state.password!);
      // On success you can update state or notify UI as needed
      state = state.copyWith(isLoading: false, errorMessage: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  // Register action
  Future<void> register() async {
    if (!state.isEmailValid ||
        !state.isPasswordValid ||
        !state.isUsernameValid) {
      state = state.copyWith(errorMessage: "Please fill all fields correctly");
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Implement _authService.register(...) similarly
      await _authService.register(
        state.email!,
        state.password!,
        state.username!,
      );
      state = state.copyWith(isLoading: false, errorMessage: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  // Validation helpers
  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) => password.length >= 6;

  bool _validateUsername(String username) => username.trim().isNotEmpty;
}
