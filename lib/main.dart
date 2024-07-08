import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktickat/screens/auth.dart';
import 'package:tiktickat/screens/home.dart';
import 'package:tiktickat/screens/splash.dart';

void main() => runApp(MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xff3B6437))),
    ));

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Splash();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'auth',
          builder: (BuildContext context, GoRouterState state) {
            return const Auth();
          },
        ),
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const Home();
          },
        ),
      ],
    ),
  ],
);
