class Credentials {
  String email;
  String password;

  Credentials({required this.email, required this.password});

  static Credentials get empty {
    return Credentials(email: "", password: "");
  }

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
