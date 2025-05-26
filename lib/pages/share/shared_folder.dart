import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tranquil_loc/api/share_infos_api.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/pages/auth/login/login.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
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
    sharedInfos = ShareInfosApi.get(widget.token!).catchError((err) {
      if (err is ApiException) {
        switch (err.statusCode) {
          default:
            context.go(Login.route);
        }
      }
      return SharedInfos.empty;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      hideNavbar: true,
      child: FutureBuilder(
        future: sharedInfos,
        builder: (context, snapshot) => Text("coucou"),
      ),
    );
  }
}
