import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/user_auth_screens/register_star_details/forget_password_provider.dart';

class ForgotPasswordState {
  final String? email;
  final bool isLoading;
  final String? errorMessage;

  ForgotPasswordState({
    this.email,
    this.isLoading = false,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    String? email,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
  (ref) => ForgotPasswordNotifier(),
);
