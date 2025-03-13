extension EmailValidator on String {
  bool isEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isStrongPassword() {
    return RegExp(
      r'^(?=(.*[a-z]){1,})(?=(.*[A-Z]){1,})(?=(.*[0-9]){1,})(?=(.*[!@#$%^&*()\-__+.;:]){1,}).{8,}$',
    ).hasMatch(this);
  }
}

extension CreateAddAll on Map {
  void createAddAll<T>(String key, Iterable<T> values) {
    if (this[key] == null) {
      this[key] = values;
    } else {
      this[key]!.addAll(values);
    }
  }

  void createAdd<T>(String key, T values) {
    if (this[key] == null) {
      this[key] = values;
    } else {
      this[key]!.add(values);
    }
  }
}
