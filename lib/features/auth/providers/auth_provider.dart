import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_coach_ui/features/auth/services/auth_service.dart';

import '../models/auth_state.dart';
import '../view_models/auth_view_model.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(AuthService()),
);
