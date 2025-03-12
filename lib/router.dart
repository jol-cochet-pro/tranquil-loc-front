import 'package:dossier_locataire/pages/auth/forgot-password/forgot-password.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/auth/register/register-cred.dart';
import 'package:dossier_locataire/pages/auth/register/register-info.dart';
import 'package:dossier_locataire/pages/auth/verify-email/need-email-verification.dart';
import 'package:dossier_locataire/pages/auth/verify-email/verify-email.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/pages/warrantors/warrantors.dart';
import 'package:dossier_locataire/shared/observers/go-router-observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String? redirectLoggedInWithEmail(BuildContext context, GoRouterState state) {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return (Login.route);
  }
  if (!user.emailVerified) {
    return (NeedEmailVerification.route);
  }
  return null;
}

String? redirectLoggedInWithoutEmail(
  BuildContext context,
  GoRouterState state,
) {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return (Login.route);
  }
  if (user.emailVerified) {
    return (Dashboard.route);
  }
  return null;
}

String? redirectLoggedOut(BuildContext context, GoRouterState state) {
  User? user = FirebaseAuth.instance.currentUser;
  return user != null ? Dashboard.route : null;
}

String? redirectFirstLog(BuildContext context, GoRouterState state) {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Login.route;
  }
  return user.emailVerified ? Login.route : null;
}

final GoRouter router = GoRouter(
  observers: [GoRouterObserver()],
  initialLocation: Login.route,
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
      path: Occupants.route,
      builder: (_, _) => Occupants(),
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
  ],
);
