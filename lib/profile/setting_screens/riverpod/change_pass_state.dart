import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/profile/setting_screens/riverpod/changepass_notifier.dart';
import 'package:matrimony/user_auth_screens/register_star_details/forget_password_provider.dart';

class ChangePassState {
  final String? oldPassword;
  final String? newPassword;
  final bool isLoading;
  final String? errorMessage;

  ChangePassState({
    this.oldPassword,
    this.newPassword,
    this.isLoading = false,
    this.errorMessage,
  });

  ChangePassState copyWith({
    String? oldPassword,
    String? newPassword,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChangePassState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final changePassProvider =
    StateNotifierProvider<ChangePassNotifier, ChangePassState>(
  (ref) => ChangePassNotifier(),
);
