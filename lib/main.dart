import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:narabuna/pages/chatbot/chatbot_page.dart';
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
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: const MyApp(),
    ),
  );
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
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => LoginViewModel(),
            child: const LoginPage(),
          ),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/chatbot',
          builder: (context, state) => const ChatBotPage(),
        ),
        GoRoute(
          path: '/kondisi',
          builder: (context, state) => const KondisiPage(),
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
