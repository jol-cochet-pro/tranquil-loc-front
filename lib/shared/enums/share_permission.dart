// ignore: constant_identifier_names
enum SharePermission { WRITE, READ_FILE, READ_INFO, NONE }

extension SharePermissionExtension on SharePermission {
  String get str {
    switch (this) {
      case SharePermission.WRITE:
        return "write";
      case SharePermission.READ_FILE:
        return "readFile";
      case SharePermission.READ_INFO:
        return "readInfo";
      case SharePermission.NONE:
        return "none";
    }
  }
}
