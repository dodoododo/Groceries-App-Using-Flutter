import 'package:freezed_annotation/freezed_annotation.dart';
import 'account_model.dart';

part 'account_response.freezed.dart';
part 'account_response.g.dart';

@freezed
class AccountResponse with _$AccountResponse {
  const factory AccountResponse({
    required AccountData data,
  }) = _AccountResponse;

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);
}

@freezed
class AccountData with _$AccountData {
  const factory AccountData({
    required AccountModel userInfo,
  }) = _AccountData;

  factory AccountData.fromJson(Map<String, dynamic> json) =>
      _$AccountDataFromJson(json);
}