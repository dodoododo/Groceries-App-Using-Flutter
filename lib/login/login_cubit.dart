import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:fluttertest/login/data/login_request.dart';
import 'package:fluttertest/login/data/login_response.dart';
import 'package:fluttertest/storage/storage.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  String email = '';
  String password = '';

  void emailChanged(String value) {
    email = value;
    validateInputs();
  }

  void passwordChanged(String value) {
    password = value;
    validateInputs();
  }

  void validateInputs() {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]{2,}@(gmail|yopmail)\.com$');
    final passRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$');

    String? emailError;
    String? passwordError;

    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      emailError = "Vui lòng nhập đúng định dạng email";
    }

    if (password.isEmpty || !passRegex.hasMatch(password)) {
      passwordError =
          "Mật khẩu cần ít nhất 6 kí tự, 1 chữ hoa, 1 chữ thường và 1 số";
    }

    emit(LoginFailure(
      email: email,
      password: password,
      emailError: emailError,
      passwordError: passwordError,
    ));
  }

  bool validateForm() {
    if (state is LoginFailure) {
      final s = state as LoginFailure;
      return s.emailError == null && s.passwordError == null;
    }
    return false;
  }

  Future<void> login(String email, String password) async {
    if (!validateForm()) return;

    emit(const LoginLoading());

    try {
      print('📤 Sending data: ${({"email": email, "password": password})}');
      final response = await Dio().post(
        'https://us-central1-skin-scanner-3c419.cloudfunctions.net/base/v1/auth-service/login',
        data: LoginRequest(email: email, password: password).toJson(),
      );

      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        await Storage.saveToken(loginResponse.accessToken);
        emit(const LoginSuccess());
      } else {
        print('Lỗi 404');
        emit(LoginFailure(
          email: email,
          password: password,
          emailError: 'Đăng nhập thất bại',
          passwordError: null,
        ));
      }
    } catch (e) {
      print('Catch' + e.toString());
      emit(LoginFailure(
        email: email,
        password: password,
        emailError: 'Đăng nhập thất bại',
        passwordError: null,
      ));
    }
  }

}
