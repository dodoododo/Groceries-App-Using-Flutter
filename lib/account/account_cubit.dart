import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'account_state.dart';
import 'package:fluttertest/storage/storage.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit()
      : super(
          const AccountState(
            name: "",
            email: "",
            avatarUrl: "",
            isLoading: true,
          ),
        ) {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    emit(state.copyWith(isLoading: true));

    try {
      final token = await Storage.getToken();
      if (token == null) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "No token found. Please log in again.",
        ));
        return;
      }

      final response = await Dio().get(
        'https://us-central1-skin-scanner-3c419.cloudfunctions.net/base/v1/user-service/me',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data']['userInfo'];

        emit(state.copyWith(
          name: data['displayName'] ?? data['username'] ?? 'Unknown User',
          email: data['email'] ?? '',
          avatarUrl: data['profilePic'] ??
              "https://ui-avatars.com/api/?name=${data['username'] ?? 'User'}",
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: response.data['message'] ?? 'Failed to load user info',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error: ${e.toString()}',
      ));
    }
  }

  Future<void> logout() async {
    await Storage.removeToken();
  }
}
