import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'account_state.dart';
import 'account_api_service.dart'; // Import service
import 'account_model.dart'; // Import model
import 'package:fluttertest/storage/storage.dart';

class AccountCubit extends Cubit<AccountState> {
  late final AccountApiService _apiService;

  AccountCubit() : super(const AccountState.loading()) {
    final dio = Dio(); 
    _apiService = AccountApiService(dio);
    
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    emit(const AccountState.loading()); 

    try {
      final token = await Storage.getToken();
      if (token == null) {
        emit(const AccountState.failure("No token found. Please log in again."));
        return;
      }
      final response = await _apiService.getAccountInfo("Bearer $token");
      final userModel = response.data.userInfo;
      emit(AccountState.success(userModel));
      
    } catch (e) {
      String errorMessage = 'Error: ${e.toString()}';
      if (e is DioException && e.response != null) {
        errorMessage = e.response?.data['message'] ?? 'Failed to load user info';
      }
      emit(AccountState.failure(errorMessage));
    }
  }

  Future<void> logout() async {
    await Storage.removeToken();
  }
}