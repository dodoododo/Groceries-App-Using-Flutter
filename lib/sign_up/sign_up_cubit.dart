import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'sign_up_state.dart';
import 'package:fluttertest/storage/storage.dart';
import 'package:fluttertest/sign_up/data/sign_up_request.dart';
import 'package:fluttertest/sign_up/data/sign_up_response.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  String firstName = '';
  String lastName = '';
  String username = '';
  String email = '';
  String password = '';

  void firstNameChanged(String value) {
    firstName = value;
    emit(state.copyWith(isFormValid: _validateForm()));
  }

  void lastNameChanged(String value) {
    lastName = value;
    emit(state.copyWith(isFormValid: _validateForm()));
  }

  void usernameChanged(String value) {
    username = value;
    emit(state.copyWith(isFormValid: _validateForm()));
  }

  void emailChanged(String value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]{2,}@(gmail|yopmail)\.com$');
    String? error;
    if (value.isEmpty || !emailRegex.hasMatch(value)) {
      error = "Vui lòng nhập đúng định dạng email";
    }
    email = value;

    emit(state.copyWith(
      email: value,
      emailError: error,
      isFormValid: _validateForm(),
    ));
  }

  void passwordChanged(String value) {
    final passRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$');
    String? error;
    if (value.isEmpty || !passRegex.hasMatch(value)) {
      error = "Mật khẩu cần ít nhất 6 kí tự, 1 chữ hoa, 1 chữ thường và 1 số";
    }
    password = value;

    emit(state.copyWith(
      password: value,
      passwordError: error,
      isFormValid: _validateForm(),
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  bool _validateForm() {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        username.isNotEmpty &&
        state.emailError == null &&
        state.passwordError == null;
  }

  Future<void> signUp() async {
    if (!_validateForm()) return;

    emit(state.copyWith(isLoading: true));

    final request = SignUpRequest(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password,
    );

    try {
      final response = await Dio().post(
        'https://us-central1-skin-scanner-3c419.cloudfunctions.net/base/v1/auth-service/register',
        data: request.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print('Response: ${response.statusCode} -> ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final signUpResponse = SignUpResponse.fromJson(response.data);
        print('✅ Success: ${signUpResponse.message}');
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: response.data['message'] ?? 'Đăng ký thất bại',
        ));
      }
    } catch (e) {
      print('❌ Lỗi đăng ký: $e');
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

}
