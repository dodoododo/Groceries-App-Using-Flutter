import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'account_response.dart';  

part 'account_api_service.g.dart';

@RestApi(baseUrl: "https://us-central1-skin-scanner-3c419.cloudfunctions.net/base/v1")
abstract class AccountApiService {
  factory AccountApiService(Dio dio, {String baseUrl}) = _AccountApiService;

  @GET("/user-service/me")
  Future<AccountResponse> getAccountInfo(
    @Header("Authorization") String token,
  );
}