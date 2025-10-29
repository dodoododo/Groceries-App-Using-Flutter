import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    String? emailError,
    String? passwordError,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool isFormValid,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? apiError,    
  }) = _LoginState;
}