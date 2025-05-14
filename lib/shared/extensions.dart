import 'package:http/http.dart' as http;
import 'package:analyzer_plugin/utilities/pair.dart';

extension StringExtension on String {
  bool isEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  bool isStrongPassword() {
    return RegExp(
      r'^(?=(.*[a-z]){1,})(?=(.*[A-Z]){1,})(?=(.*[0-9]){1,})(?=(.*[!@#$%^&*()\-__+.;:]){1,}).{8,}$',
    ).hasMatch(this);
  }
}

extension PasswordValidator on String {}

extension MapExtension on Map {
  void createAddAll<T>(String key, Iterable<T> values) {
    if (this[key] == null) {
      this[key] = values;
    } else {
      this[key]!.addAll(values);
    }
  }

  void createAdd<T>(String key, T value) {
    if (this[key] == null) {
      this[key] = [value];
    } else {
      this[key]!.add(value);
    }
  }
}

extension MapEntryExtension<T, K> on MapEntry<T, K> {
  Pair<T, K> toPair() {
    return Pair(key, value);
  }
}

extension HttpResponseExtension on http.Response {
  bool get isOK {
    return (statusCode ~/ 100) == 2;
  }
}
