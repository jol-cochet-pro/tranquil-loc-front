import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tranquil_loc/api/share_infos_api.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/pages/auth/login/login.dart';
import 'package:tranquil_loc/shared/models/shared_infos.dart';

class SharedFolder extends StatefulWidget {
  final String? token;

  const SharedFolder({super.key, this.token});

  static final route = "/shared-folder";

  @override
  State<SharedFolder> createState() => _SharedFolderState();
}

class _SharedFolderState extends State<SharedFolder> {
  late Future<SharedInfos> sharedInfos;

  @override
  void initState() {
    if (widget.token == null) {
      context.go(Login.route);
      return;
    }
    sharedInfos = ShareInfosApi.get(widget.token!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(sharedInfos);
    return PageLayout(hideNavbar: true, child: Text("Coucou"));
  }
}
