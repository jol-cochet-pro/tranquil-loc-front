class Otp {
  int code;

  Otp({required this.code});

  static Otp get empty {
    return Otp(code: -1);
  }

  Map<String, dynamic> toJson() {
    return {"code": code};
  }
}
