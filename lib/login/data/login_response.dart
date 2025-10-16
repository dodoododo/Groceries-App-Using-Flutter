class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String message;
  final int statusCode;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
    required this.statusCode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final tokens = data != null ? data['tokens'] : null;

    return LoginResponse(
      accessToken: tokens?['accessToken'],
      refreshToken: tokens?['refreshToken'],
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}
