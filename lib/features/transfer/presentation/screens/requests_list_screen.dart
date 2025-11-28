import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius_transfer_app/core/errors/network_exceptions.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_card.dart';

class RequestsListScreen extends StatelessWidget {
  const RequestsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Transfer Requests'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/submit'),
            tooltip: 'New Transfer',
          ),
        ],
      ),
      body: BlocBuilder<TransferCubit, TransferState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => context.read<TransferCubit>().refreshTransfers(),
            child: state.when(
              initial: () => const Center(
                child: Text('Pull to load transfers'),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (transfers) {
                return _buildTransfersList(transfers, context);
              },
              created: (transfer, transfers) {
                return _buildTransfersList(transfers, context);
              },
              error: (error) => _ErrorState(
                message: NetworkExceptions.getErrorMessage(error),
                onRetry: () => context.read<TransferCubit>().loadTransfers(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransfersList(List<TransferRequest> transfers, BuildContext context) {
    if (transfers.isEmpty) {
      return _EmptyState(
        onCreateTransfer: () => context.push('/submit'),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: transfers.length,
      itemBuilder: (context, index) {
        final transfer = transfers[index];
        return TransferCard(
          transfer: transfer,
          onTap: () => context.push('/details', extra: transfer),
        );
      },
    );
  }
}

// Empty state widget
class _EmptyState extends StatelessWidget {
  final VoidCallback onCreateTransfer;

  const _EmptyState({required this.onCreateTransfer});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 100,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Transfer Requests',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'You haven\'t created any transfer requests yet.\nCreate your first one to get started!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onCreateTransfer,
              icon: const Icon(Icons.add),
              label: const Text('Create Transfer'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
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
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 100,
              color: AppColors.error,
            ),
            const SizedBox(height: 24),
            const Text(
              'Something Went Wrong',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
