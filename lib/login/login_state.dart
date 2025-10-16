abstract class LoginState {
  // final String? emailError;
  // final String? passwordError;
  // final bool isFormValid;
  // final bool isLoading;
  // final bool isSuccess;

  // const LoginState({
  //   this.emailError,
  //   this.passwordError,
  //   this.isFormValid = false,
  //   this.isLoading = false,
  //   this.isSuccess = false,
  // });

  // LoginState copyWith({
  //   String? emailError,
  //   String? passwordError,
  //   bool? isFormValid,
  //   bool? isLoading,
  //   bool? isSuccess,
  // }) {
  //   return LoginState(
  //     emailError: emailError,
  //     passwordError: passwordError,
  //     isFormValid: isFormValid ?? this.isFormValid,
  //     isLoading: isLoading ?? this.isLoading,
  //     isSuccess: isSuccess ?? this.isSuccess,
  //   );
  // }
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}

class LoginFailure extends LoginState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;

  const LoginFailure({
    required this.email,
    required this.password,
    this.emailError,
    this.passwordError,
  });

  LoginFailure copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
  }) {
    return LoginFailure(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}
