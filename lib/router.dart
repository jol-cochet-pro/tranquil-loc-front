import 'package:dossier_locataire/components/navbar.dart';
import 'package:dossier_locataire/pages/auth/forgot-password/forgot_password.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/auth/register/register_cred.dart';
import 'package:dossier_locataire/pages/auth/register/register_info.dart';
import 'package:dossier_locataire/pages/auth/verify-email/need_email_verification.dart';
import 'package:dossier_locataire/pages/auth/verify-email/verify_email.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/pages/landing/landing.dart';
import 'package:dossier_locataire/pages/occupants/add_occupant.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/pages/occupants/update_occupant.dart';
import 'package:dossier_locataire/pages/warrantors/add_warrantor.dart';
import 'package:dossier_locataire/pages/warrantors/update_warrantor.dart';
import 'package:dossier_locataire/pages/warrantors/warrantors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String? redirectLoggedInWithEmail(BuildContext context, GoRouterState state) {
  // TODO FIREBASE REPLACEMENT
  // User? user = FirebaseAuth.instance.currentUser;
  // if (user == null) {
  //   return (Login.route);
  // }
  // if (!user.emailVerified) {
  //   return (NeedEmailVerification.route);
  // }
  return null;
}

String? redirectLoggedInWithoutEmail(
  BuildContext context,
  GoRouterState state,
) {
  // TODO FIREBASE REPLACEMENT
  // User? user = FirebaseAuth.instance.currentUser;
  // if (user == null) {
  //   return (Login.route);
  // }
  // if (user.emailVerified) {
  //   return (Dashboard.route);
  // }
  return null;
}

String? redirectLoggedOut(BuildContext context, GoRouterState state) {
  // TODO FIREBASE REPLACEMENT
  // User? user = FirebaseAuth.instance.currentUser;
  // return user != null ? Dashboard.route : null;
  return null;
}

String? redirectFirstLog(BuildContext context, GoRouterState state) {
  // TODO FIREBASE REPLACEMENT

  // User? user = FirebaseAuth.instance.currentUser;
  // if (user == null) {
  //   return Login.route;
  // }
  // return user.emailVerified ? Login.route : null;
  return null;
}

final GoRouter router = GoRouter(
  initialLocation: Login.route,
  redirect: (context, state) {
    Navbar.setSelected(state.matchedLocation);
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
      redirect: redirectLoggedInWithoutEmail,
    ),
    GoRoute(
      path: NeedEmailVerification.route,
      builder: (_, state) => NeedEmailVerification(),
      redirect: redirectLoggedInWithoutEmail,
    ),
    GoRoute(
      path: VerifiyEmail.route,
      builder:
          (_, state) =>
              VerifiyEmail(actionCode: state.uri.queryParameters["oobCode"]),
      redirect: redirectLoggedInWithoutEmail,
    ),
    GoRoute(path: Landing.route, builder: (_, state) => Landing()),
  ],
);
