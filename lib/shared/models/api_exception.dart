class ApiException extends Error {
  String message;
  int statusCode;

  ApiException({required this.message, required this.statusCode});

  factory ApiException.fromApi(Map<String, dynamic>? data) {
    return switch (data) {
      {"statusCode": int statusCode, "message": String message} => ApiException(
        statusCode: statusCode,
        message: message,
      ),
      _ => throw const FormatException("Failed to load Error"),
    };
  }
}
