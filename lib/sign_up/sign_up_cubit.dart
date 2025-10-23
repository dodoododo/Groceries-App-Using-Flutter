import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'sign_up_state.dart';
import 'sign_up_api_service.dart'; 
import 'sign_up_request.dart';   

class SignUpCubit extends Cubit<SignUpState> {
  late final SignUpApiService _apiService;

  SignUpCubit() : super(const SignUpState()) {
    final dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    _apiService = SignUpApiService(dio);
  }

  void firstNameChanged(String value) {
    emit(state.copyWith(
      firstName: value,
      isFormValid: _validateForm(firstName: value),
    ));
  }

  void lastNameChanged(String value) {
    emit(state.copyWith(
      lastName: value,
      isFormValid: _validateForm(lastName: value),
    ));
  }

  void usernameChanged(String value) {
    emit(state.copyWith(
      username: value,
      isFormValid: _validateForm(username: value),
    ));
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
      isFormValid: _validateForm(email: value, emailError: error),
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
      isFormValid: _validateForm(password: value, passwordError: error),
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  bool _validateForm({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
  }) {
    final newEmail = email ?? state.email;
    final newPassword = password ?? state.password;
    final newFirstName = firstName ?? state.firstName;
    final newLastName = lastName ?? state.lastName;
    final newUsername = username ?? state.username;
    
    final newEmailError = (email != null) ? emailError : state.emailError;
    final newPasswordError = (password != null) ? passwordError : state.passwordError;

    return newEmail.isNotEmpty &&
        newPassword.isNotEmpty &&
        newFirstName.isNotEmpty &&
        newLastName.isNotEmpty &&
        newUsername.isNotEmpty &&
        newEmailError == null &&
        newPasswordError == null;
  }

  Future<void> signUp() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final request = SignUpRequest(
      firstName: state.firstName,
      lastName: state.lastName,
      username: state.username,
      email: state.email,
      password: state.password,
    );

    try {
      print('📤 Gửi SignUp Request: ${request.toJson()}');
      final response = await _apiService.signUp(request);

      print('✅ Success: ${response.message}');
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      print('❌ Lỗi đăng ký: $e');
      String errorMessage = 'Đăng ký thất bại. Vui lòng thử lại.';
      
      if (e is DioException && e.response?.data['message'] != null) {
        errorMessage = e.response!.data['message'];
      }
      
      emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
    }
  }
}