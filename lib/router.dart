import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/components/navbar.dart';
import 'package:tranquil_loc/pages/auth/forgot-password/forgot_password.dart';
import 'package:tranquil_loc/pages/auth/login/login.dart';
import 'package:tranquil_loc/pages/auth/register/register_cred.dart';
import 'package:tranquil_loc/pages/auth/register/register_info.dart';
import 'package:tranquil_loc/pages/auth/verify-email/need_email_verification.dart';
import 'package:tranquil_loc/pages/dashboard/dashboard.dart';
import 'package:tranquil_loc/pages/landing/landing.dart';
import 'package:tranquil_loc/pages/occupants/add_occupant.dart';
import 'package:tranquil_loc/pages/occupants/occupants.dart';
import 'package:tranquil_loc/pages/occupants/update_occupant.dart';
import 'package:tranquil_loc/pages/shared_folder/shared_folder.dart';
import 'package:tranquil_loc/pages/warrantors/add_warrantor.dart';
import 'package:tranquil_loc/pages/warrantors/update_warrantor.dart';
import 'package:tranquil_loc/pages/warrantors/warrantors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String? redirectLoggedIn(BuildContext _, GoRouterState _) {
  if (AuthApi.user == null) {
    return Login.route;
  }
  if (!AuthApi.user!.infosFilled) {
    return RegisterInfos.route;
  }
  if (!AuthApi.user!.emailVerified) {
    return NeedEmailVerification.route;
  }
  return null;
}

String? redirectLoggedOut(BuildContext _, GoRouterState state) {
  if (AuthApi.user != null) {
    return Dashboard.route;
  }
  return null;
}

String? redirectLoggedInWithoutValidInfos(BuildContext _, GoRouterState _) {
  if (AuthApi.user == null) {
    return Login.route;
  }
  if (AuthApi.user!.infosFilled) {
    return Dashboard.route;
  }
  return null;
}

String? redirectLoggedInWithoutValidEmail(BuildContext _, GoRouterState _) {
  if (AuthApi.user == null) {
    return Login.route;
  }
  if (!AuthApi.user!.infosFilled) {
    return RegisterInfos.route;
  }
  if (AuthApi.user!.emailVerified) {
    return Dashboard.route;
  }
  return null;
}

final GoRouter router = GoRouter(
  initialLocation: Login.route,
  redirect: (context, state) async {
    Navbar.setSelected(state.matchedLocation);
    try {
      AuthApi.user = await AuthApi.getMe();
    } catch (_) {
      AuthApi.user = null;
    }
    return null;
  },
  routes: [
    GoRoute(path: '/', redirect: (_, _) => Login.route),
    // Logged in with validated email
    GoRoute(
      path: Dashboard.route,
      builder: (_, _) => Dashboard(),
      redirect: redirectLoggedIn,
    ),
    GoRoute(
      path: Warrantors.route,
      builder: (_, _) => Warrantors(),
      redirect: redirectLoggedIn,
    ),
    GoRoute(
      path: AddWarrantor.route,
      builder: (_, _) => AddWarrantor(),
      redirect: redirectLoggedIn,
    ),
    GoRoute(
      path: UpdateWarrantor.route,
      builder:
          (_, state) =>
              UpdateWarrantor(warrantorId: state.pathParameters["id"]!),
      redirect: redirectLoggedIn,
    ),
    GoRoute(
      path: Occupants.route,
      builder: (_, _) => Occupants(),
      redirect: redirectLoggedIn,
    ),
    GoRoute(
      path: AddOccupant.route,
      builder: (_, _) => AddOccupant(),
      redirect: redirectLoggedIn,
    ),
    GoRoute(
      path: UpdateOccupant.route,
      builder:
          (_, state) => UpdateOccupant(occupantId: state.pathParameters["id"]!),
      redirect: redirectLoggedIn,
    ),
    // Logged out
    GoRoute(
      path: SharedFolder.route,
      builder:
          (_, state) => SharedFolder(token: state.uri.queryParameters["token"]),
      redirect: redirectLoggedOut,
    ),
    GoRoute(
      path: Login.route,
      builder: (_, _) => Login(),
      redirect: redirectLoggedOut,
    ),
    GoRoute(
      path: RegisterCred.route,
      builder: (_, _) => RegisterCred(),
      redirect: redirectLoggedOut,
    ),
    GoRoute(
      path: ForgotPassword.route,
      builder: (_, _) => ForgotPassword(),
      redirect: redirectLoggedOut,
    ),
    // Logged in without validated email
    GoRoute(
      path: RegisterInfos.route,
      builder: (_, _) => RegisterInfos(),
      redirect: redirectLoggedInWithoutValidInfos,
    ),
    GoRoute(
      path: NeedEmailVerification.route,
      builder: (_, state) => NeedEmailVerification(),
      redirect: redirectLoggedInWithoutValidEmail,
    ),
    GoRoute(path: Landing.route, builder: (_, state) => Landing()),
  ],
);
