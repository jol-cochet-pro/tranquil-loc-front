import 'package:dossier_locataire/api/auth_api.dart';
import 'package:dossier_locataire/components/navbar.dart';
import 'package:dossier_locataire/pages/auth/forgot-password/forgot_password.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/auth/register/register_cred.dart';
import 'package:dossier_locataire/pages/auth/register/register_info.dart';
import 'package:dossier_locataire/pages/auth/verify-email/need_email_verification.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/pages/landing/landing.dart';
import 'package:dossier_locataire/pages/occupants/add_occupant.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/pages/occupants/update_occupant.dart';
import 'package:dossier_locataire/pages/warrantors/add_warrantor.dart';
import 'package:dossier_locataire/pages/warrantors/update_warrantor.dart';
import 'package:dossier_locataire/pages/warrantors/warrantors.dart';
import 'package:dossier_locataire/shared/models/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<String?> redirectLoggedInWithEmail(
  BuildContext context,
  GoRouterState state,
) async {
  try {
    if (AuthApi.user == null) {
      return (Login.route);
    }
    if (!AuthApi.user!.infosFilled) {
      return (RegisterInfos.route);
    }
    if (!AuthApi.user!.emailVerified) {
      return (NeedEmailVerification.route);
    }
    return null;
  } catch (_) {
    return (Login.route);
  }
}

Future<String?> redirectLoggedInWithoutEmail(
  BuildContext context,
  GoRouterState state,
) async {
  try {
    if (AuthApi.user == null) {
      return (Login.route);
    }
    if (!AuthApi.user!.emailVerified) {
      return (NeedEmailVerification.route);
    }
    return null;
  } catch (err) {
    return (Login.route);
  }
}

Future<String?> redirectFirstLog(
  BuildContext context,
  GoRouterState state,
) async {
  try {
    User user = await AuthApi.getMe();
    if (user.emailVerified) {
      return (Login.route);
    }
    return null;
  } catch (_) {
    return (Login.route);
  }
}

final GoRouter router = GoRouter(
  initialLocation: Login.route,
  redirect: (context, state) async {
    Navbar.setSelected(state.matchedLocation);
    try {
      AuthApi.user = await AuthApi.getMe();
    } catch (_) {
      return (Login.route);
    }
    return null;
  },
  routes: [
    GoRoute(path: '/', redirect: (_, _) => Login.route),
    // Logged in with validated email
    GoRoute(
      path: Dashboard.route,
      builder: (_, _) => Dashboard(),
      redirect: redirectLoggedInWithEmail,
    ),
    GoRoute(
      path: Warrantors.route,
      builder: (_, _) => Warrantors(),
      redirect: redirectLoggedInWithEmail,
    ),
    GoRoute(
      path: AddWarrantor.route,
      builder: (_, _) => AddWarrantor(),
      redirect: redirectLoggedInWithEmail,
    ),
    GoRoute(
      path: UpdateWarrantor.route,
      builder:
          (_, state) =>
              UpdateWarrantor(warrantorId: state.pathParameters["id"]!),
      redirect: redirectLoggedInWithEmail,
    ),
    GoRoute(
      path: Occupants.route,
      builder: (_, _) => Occupants(),
      redirect: redirectLoggedInWithEmail,
    ),
    GoRoute(
      path: AddOccupant.route,
      builder: (_, _) => AddOccupant(),
      redirect: redirectLoggedInWithEmail,
    ),
    GoRoute(
      path: UpdateOccupant.route,
      builder:
          (_, state) => UpdateOccupant(occupantId: state.pathParameters["id"]!),
      redirect: redirectLoggedInWithEmail,
    ),
    // Logged out
    GoRoute(path: Login.route, builder: (_, _) => Login()),
    GoRoute(path: RegisterCred.route, builder: (_, _) => RegisterCred()),
    GoRoute(path: ForgotPassword.route, builder: (_, _) => ForgotPassword()),
    // Logged in without validated email
    GoRoute(
      path: RegisterInfos.route,
      builder: (_, _) => RegisterInfos(),
      redirect: redirectLoggedInWithoutEmail,
    ),
    GoRoute(
      path: NeedEmailVerification.route,
      builder: (_, state) => NeedEmailVerification(),
      redirect: redirectLoggedInWithoutEmail,
    ),
    GoRoute(path: Landing.route, builder: (_, state) => Landing()),
  ],
);
