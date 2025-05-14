class UserJwt {
  String id;
  String email;
  bool emailVerified;
  bool infosFilled;
  String accessToken;

  UserJwt({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.infosFilled,
    required this.accessToken,
  });

  factory UserJwt.fromApi(Map<String, dynamic>? data) {
    return switch (data) {
      {
        "id": String id,
        "email": String email,
        "emailVerified": bool emailVerified,
        "infosFilled": bool infosFilled,
        "accessToken": String accessToken,
      } => UserJwt(
        id: id,
        email: email,
        emailVerified: emailVerified,
        infosFilled: infosFilled,
        accessToken: accessToken
      ),
      {
        "id": String id,
        "email": String email,
        "emailVerified": bool emailVerified,
        "infosFilled": bool infosFilled,
      } => UserJwt(
        id: id,
        email: email,
        emailVerified: emailVerified,
        infosFilled: infosFilled,
        accessToken: ""
      ),
      _ => throw const FormatException("Failed to load UserJwt"),
    };
  }
}