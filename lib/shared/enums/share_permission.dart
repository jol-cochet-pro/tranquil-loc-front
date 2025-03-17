enum SharePermission { write, readFile, readInfo, none }

extension SharePermissionExtension on SharePermission {
  String get str {
    switch (this) {
      case SharePermission.write:
        return "write";
      case SharePermission.readFile:
        return "readFile";
      case SharePermission.readInfo:
        return "readInfo";
      case SharePermission.none:
        return "none";
    }
  }
}
