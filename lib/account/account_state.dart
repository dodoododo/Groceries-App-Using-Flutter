import 'package:freezed_annotation/freezed_annotation.dart';
import 'account_model.dart'; // Import model dữ liệu

part 'account_state.freezed.dart';

@freezed
sealed class AccountState with _$AccountState {
  const factory AccountState.loading() = _Loading;
  const factory AccountState.success(AccountModel user) = _Success;
  const factory AccountState.failure(String errorMessage) = _Failure;
}