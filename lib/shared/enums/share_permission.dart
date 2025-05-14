// ignore: constant_identifier_names
enum SharePermission { WRITE, READ_FILE, READ_INFO, NONE }

extension SharePermissionExtension on SharePermission {
  String get str {
    switch (this) {
      case SharePermission.WRITE:
        return "WRITE";
      case SharePermission.READ_FILE:
        return "READ_FILE";
      case SharePermission.READ_INFO:
        return "READ_INFO";
      case SharePermission.NONE:
        return "NONE";
    }
  }
}
