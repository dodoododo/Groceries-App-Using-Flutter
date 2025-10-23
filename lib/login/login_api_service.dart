import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'login_request.dart';
import 'login_response.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: "https://us-central1-skin-scanner-3c419.cloudfunctions.net/base/v1")
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String baseUrl}) = _LoginApiService;

  @POST("/auth-service/login")
  Future<LoginResponse> login(
    @Body() LoginRequest request,
  );
}