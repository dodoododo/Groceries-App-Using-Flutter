class SignUpState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isPasswordVisible;
  final bool isFormValid;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const SignUpState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isPasswordVisible = false,
    this.isFormValid = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  SignUpState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isPasswordVisible,
    bool? isFormValid,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
