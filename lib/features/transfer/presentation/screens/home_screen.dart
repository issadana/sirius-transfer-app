import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius_transfer_app/core/errors/network_exceptions.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/common/empty_state_widget.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/common/error_state_widget.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_card/transfer_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TransferCubit _transferCubit;

  @override
  void initState() {
    super.initState();
    _transferCubit = context.read<TransferCubit>();
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
                const _HeaderSection(),
                const SizedBox(height: 24),
                _buildContent(state),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(TransferState state) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const _LoadingState(),
      loaded: (transfers) => _TransfersSection(transfers: transfers),
      created: (_, transfers) => _TransfersSection(transfers: transfers),
      error: (error) => ErrorStateWidget(
        message: NetworkExceptions.getErrorMessage(error),
        onRetry: () => _transferCubit.loadTransfers(),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const _ActionButtons(),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(48.0),
      child: CircularProgressIndicator(),
    );
  }
}

class _TransfersSection extends StatelessWidget {
  final List<TransferRequest> transfers;

  const _TransfersSection({required this.transfers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TransfersSectionHeader(transferCount: transfers.length),
        const SizedBox(height: 16),
        _TransfersList(transfers: transfers),
      ],
    );
  }
}

class _TransfersSectionHeader extends StatelessWidget {
  final int transferCount;

  const _TransfersSectionHeader({required this.transferCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Recent $transferCount Transfers',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Text(
            '$transferCount total',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransfersList extends StatelessWidget {
  final List<TransferRequest> transfers;

  const _TransfersList({required this.transfers});

  @override
  Widget build(BuildContext context) {
    if (transfers.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.account_balance_wallet_outlined,
        title: 'No transfers yet',
        message: 'Create your first transfer to get started',
        actionLabel: 'Create Transfer',
        onActionPressed: () => context.push('/submit'),
      );
    }

    return Column(
      children: transfers.map((transfer) {
        return TransferCard(
          transfer: transfer,
          onTap: () => context.push('/details', extra: transfer),
        );
      }).toList(),
    );
  }
}
