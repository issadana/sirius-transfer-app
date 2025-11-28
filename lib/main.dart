import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirius_transfer_app/core/injection/injection.dart';
import 'package:sirius_transfer_app/core/resources/app_theme.dart';
import 'package:sirius_transfer_app/core/router/app_router.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/cubit/transfer_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();

  runApp(const SiriusTransferApp());
}

class SiriusTransferApp extends StatelessWidget {
  const SiriusTransferApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TransferCubit>()..loadTransfers(),
      child: MaterialApp.router(
        title: 'SIRIUS Transfer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
