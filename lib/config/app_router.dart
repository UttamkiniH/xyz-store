import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xyz_store/main.dart';
import 'package:xyz_store/ui/screens/screens.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    // debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const AuthWrapper();
        },
      ),

      GoRoute(
        path: '/login',
        name: 'login_page',
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/loading_screen',
        name: 'loading_screen',
        builder: (context, state) {
          return const LoadingScreen();
        },
      ),
      //*home->descriptiom->cart(2)

      GoRoute(
        path: '/home:index',
        name: 'home',
        builder: ((BuildContext context, GoRouterState state) {
          return BottomNavBar(
            index: int.parse(
              state.params['index']!,
            ),
          );
        }),
      ),

      // GoRoute(path: '/'),
      //*home->description
      GoRoute(
        path: '/description_page:id',
        name: 'description_page',
        builder: ((context, state) {
          return DescriptionPage(
            index: int.parse(
              state.params['id']!,
            ),
          );
        }),
      ),

      //*cart->location
      GoRoute(
          path: '/location',
          name: 'location',
          builder: (context, state) {
            return const GetLocationPage();
          },
          routes: [
            GoRoute(
                path: 'orders',
                name: 'orders',
                builder: (context, state) {
                  return const OrderPage();
                },
                routes: [
                  GoRoute(
                    path: 'completed',
                    name: 'completed',
                    builder: (context, state) {
                      return const OrderCompletedPage();
                    },
                  )
                ])
          ])
    ],
  );
}
