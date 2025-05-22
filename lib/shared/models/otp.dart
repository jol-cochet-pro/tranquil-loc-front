class Otp {
  int code;

  Otp({required this.code});

  static Otp get empty {
    return Otp(code: -1);
  }

  static Map<String, String> toApi(Otp otp) {
    return {"code": otp.code.toString()};
  }
}
