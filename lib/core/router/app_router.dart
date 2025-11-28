import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/screens/home_screen.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/screens/request_details_screen.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/screens/requests_list_screen.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/screens/submit_transfer_screen.dart';

// Global router configuration using GoRouter
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // - / -> Home Screen
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      // - /submit -> Submit Transfer Screen
      GoRoute(
        path: '/submit',
        name: 'submit',
        builder: (context, state) => const SubmitTransferScreen(),
      ),
      // - /requests -> Requests List Screen
      GoRoute(
        path: '/requests',
        name: 'requests',
        builder: (context, state) => const RequestsListScreen(),
      ),
      // - /details -> Request Details Screen
      GoRoute(
        path: '/details',
        name: 'details',
        builder: (context, state) {
          final transfer = state.extra as TransferRequest;
          return RequestDetailsScreen(transfer: transfer);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    ),
  );
}
