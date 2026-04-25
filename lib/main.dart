import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:narabuna/pages/chatbot/chatbot_page.dart';
import 'package:narabuna/pages/chatbot/chatbot_view_model.dart';
import 'package:narabuna/pages/home/home_view_model.dart';
import 'package:narabuna/pages/kondisi/kondisi_detail_page.dart';
import 'package:narabuna/pages/kondisi/kondisi_view_model.dart';
import 'package:narabuna/pages/profile/profile_page.dart';
import 'package:narabuna/pages/register/register_view_model.dart';
import 'package:provider/provider.dart';

import 'package:narabuna/pages/home/home_page.dart';
import 'package:narabuna/pages/kondisi/kondisi_page.dart';
import 'package:narabuna/pages/login/login_page.dart';
import 'package:narabuna/pages/login/login_view_model.dart';
import 'package:narabuna/pages/register/register_page.dart';
import 'package:narabuna/auth/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authState = AuthState();
  await authState.loadSession();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authState),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => KondisiViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

Page<dynamic> noTransitionPage(GoRouterState state, Widget child) {
  return NoTransitionPage(key: state.pageKey, child: child);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();

    final router = GoRouter(
      refreshListenable: authState,
      initialLocation: '/home',
      redirect: (context, state) {
        final isLoggedIn = authState.isLoggedIn;
        final isLoginPage = state.uri.toString() == '/login';
        final isRegisterPage = state.uri.toString() == '/register';

        if (!isLoggedIn && !isLoginPage && !isRegisterPage) {
          return '/login';
        }

        if (isLoggedIn && isLoginPage) {
          return '/home';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => noTransitionPage(
            state,
            ChangeNotifierProvider(
              create: (_) => LoginViewModel(),
              child: const LoginPage(),
            ),
          ),
        ),
        GoRoute(
          path: '/register',
          pageBuilder: (context, state) =>
              noTransitionPage(state, const RegisterPage()),
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) =>
              noTransitionPage(state, const HomePage()),
        ),
        GoRoute(
          path: '/chatbot',
          pageBuilder: (context, state) =>
              noTransitionPage(state, const ChatBotPage()),
        ),
        GoRoute(
          path: '/kondisi',
          pageBuilder: (context, state) =>
              noTransitionPage(state, const KondisiPage()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              noTransitionPage(state, const ProfilePage()),
        ),
        GoRoute(
          path: '/kondisi/:id',
          pageBuilder: (context, state) => noTransitionPage(
            state,
            KondisiDetailPage(visitId: state.pathParameters['id'] ?? ''),
          ),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Narabuna',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SFProDisplay', useMaterial3: true),
      routerConfig: router,
    );
  }
}
