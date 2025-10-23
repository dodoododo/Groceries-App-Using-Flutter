import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'login_request.dart';
import 'login_response.dart';
import 'package:fluttertest/storage/storage.dart';
import 'login_api_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late final LoginApiService _apiService;

  LoginCubit() : super(const LoginState()) {
    final dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    _apiService = LoginApiService(dio);
  }

  void emailChanged(String value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]{2,}@(gmail|yopmail)\.com$');
    String? error;
    if (value.isEmpty || !emailRegex.hasMatch(value)) {
      error = "Vui lòng nhập đúng định dạng email";
    }

    emit(state.copyWith(
      email: value,
      emailError: error,
      isFormValid: _validateForm(
        email: value,
        password: state.password,
        emailError: error,
        passwordError: state.passwordError,
      ),
    ));
  }

  void passwordChanged(String value) {
    final passRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$');
    String? error;
    if (value.isEmpty || !passRegex.hasMatch(value)) {
      error = "Mật khẩu cần ít nhất 6 kí tự, 1 chữ hoa, 1 chữ thường và 1 số";
    }

    emit(state.copyWith(
      password: value,
      passwordError: error,
      isFormValid: _validateForm(
        email: state.email,
        password: value,
        emailError: state.emailError,
        passwordError: error,
      ),
    ));
  }

  bool _validateForm({
    required String email,
    required String password,
    String? emailError,
    String? passwordError,
  }) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        emailError == null &&
        passwordError == null;
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> login() async {
    if (!state.isFormValid) return;
    emit(state.copyWith(isLoading: true, apiError: null));

    try {
      final request = LoginRequest(email: state.email, password: state.password);
      
      print('📤 Gửi Login Request: ${request.toJson()}');

      final loginResponse = await _apiService.login(request);

      final token = loginResponse.data.tokens.accessToken;

      await Storage.saveToken(token);
      emit(state.copyWith(isLoading: false, isSuccess: true));

    } catch (e) {
      print('Login Failed: $e');
      String errorMessage = 'Đăng nhập thất bại. Vui lòng thử lại.';
      
      if (e is DioException) {
         print('DioException response: ${e.response?.data}');
         if (e.response?.data['message'] != null) {
           errorMessage = e.response!.data['message'];
         }
      }
      
      emit(state.copyWith(isLoading: false, apiError: errorMessage));
    }
  }
}