class SignUpResponse {
  final int statusCode;
  final String message;
  final String timestamp;

  SignUpResponse({
    required this.statusCode,
    required this.message,
    required this.timestamp,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}
