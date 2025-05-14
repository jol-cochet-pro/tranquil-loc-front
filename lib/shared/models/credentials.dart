
class Credentials {
  String email;
  String password;

  Credentials({required this.email, required this.password});

  static Map<String, String> toApi(Credentials cred) {
    return {
      "email":cred.email,
      "password":cred.password,
    };
  }
}