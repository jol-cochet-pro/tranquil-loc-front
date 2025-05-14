class ApiException extends Error {
  dynamic response;
  int status;
  Object options;
  String message;
  String name;

  ApiException({
    required this.response,
    required this.status,
    required this.options,
    required this.message,
    required this.name,
  });

  factory ApiException.fromApi(Map<String, dynamic>? data) {
    return switch (data) {
      {
        "response": var response,
        "status": int status,
        "options": var options,
        "message": String message,
        "name": String name,
      } =>
        ApiException(
          response: response,
          status: status,
          options: options,
          message: message,
          name: name,
        ),
      _ => throw const FormatException("Failed to load Error"),
    };
  }
}