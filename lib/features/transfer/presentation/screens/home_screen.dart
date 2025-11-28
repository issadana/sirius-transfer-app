import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius_transfer_app/core/errors/network_exceptions.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TransferCubit transferCubit;

  @override
  void initState() {
    transferCubit = context.read<TransferCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('SIRIUS Transfer'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<TransferCubit, TransferState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Welcome to SIRIUS',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Cross-Wallet Transfer App',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => context.push('/submit'),
                              icon: const Icon(Icons.send),
                              label: const Text('Send Money'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => context.push('/requests'),
                              icon: const Icon(Icons.list),
                              label: const Text('View All'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Recent Transfers Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Recent Transfers',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      state.maybeWhen(
                        loaded: (transfers) => _buildTotalLength(transfers),
                        created: (transfer, transfers) => _buildTotalLength(transfers),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // State-based Content
                state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => const Padding(
                    padding: EdgeInsets.all(48.0),
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (transfers) {
                    return _buildTransferList(context, transfers);
                  },
                  created: (_, transfers) {
                    return _buildTransferList(context, transfers);
                  },
                  error: (error) => _ErrorState(
                    message: NetworkExceptions.getErrorMessage(error),
                    onRetry: () => context.read<TransferCubit>().loadTransfers(),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Text _buildTotalLength(List<TransferRequest> transfers) {
    return Text(
      '${transfers.length} total',
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildTransferList(BuildContext context, List<TransferRequest> transfers) {
    if (transfers.isEmpty) {
      return _EmptyState(
        onCreateTransfer: () => context.push('/submit'),
      );
    }

    return Column(
      children: [
        ...transfers.map(
          (transfer) => TransferCard(
            transfer: transfer,
            onTap: () => context.push(
              '/details',
              extra: transfer,
            ),
          ),
        ),
      ],
    );
  }
}

// Empty state widget
class _EmptyState extends StatelessWidget {
  final VoidCallback onCreateTransfer;

  const _EmptyState({required this.onCreateTransfer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No transfers yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create your first transfer to get started',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onCreateTransfer,
            icon: const Icon(Icons.add),
            label: const Text('Create Transfer'),
          ),
        ],
      ),
    );
  }
}

// Error state widget
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            size: 80,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
