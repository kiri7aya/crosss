
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/login.dart';
import 'models/auth.dart';
import 'home.dart'; // <-- Import MainNavigationPage

void main() {
  runApp(const Flowwow());
}

class Flowwow extends StatefulWidget {
  const Flowwow({super.key});

  @override
  State<Flowwow> createState() => _FlowwowState();
}

class _FlowwowState extends State<Flowwow> {
  final FlowwowAuth _auth = FlowwowAuth();

  late final GoRouter _router = GoRouter(
    initialLocation: '/login', // Default route
    redirect: (context, state) async {
      final loggedIn = await _auth.loggedIn;
      final isLoggingIn = state.matchedLocation == '/login';
      if (!loggedIn && !isLoggingIn) return '/login';  // Redirect to login
      if (loggedIn && isLoggingIn) return '/home';  // If logged in, go to home
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(
          onLogIn: (credentials) async {
            final success = await _auth.signIn(credentials.username, credentials.password);
            if (success) context.go('/home');  // Go to home after successful login
          },
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainNavigationPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Flower Delivery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
    );
  }
}
