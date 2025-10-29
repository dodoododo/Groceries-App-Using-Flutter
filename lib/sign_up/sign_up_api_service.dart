import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'sign_up_request.dart';
import 'sign_up_response.dart';

part 'sign_up_api_service.g.dart';

@RestApi(baseUrl: "https://us-central1-skin-scanner-3c419.cloudfunctions.net/base/v1")
abstract class SignUpApiService {
  factory SignUpApiService(Dio dio, {String baseUrl}) = _SignUpApiService;

  @POST("/auth-service/register")
  Future<SignUpResponse> signUp(
    @Body() SignUpRequest request,
  );
}