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
            tooltip: 'Create Transfer',
          ),
        ],
      ),
      body: BlocBuilder<TransferCubit, TransferState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => context.read<TransferCubit>().refreshTransfers(),
            child: _buildContent(context, state),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, TransferState state) {
    return state.when(
      initial: () => const _InitialState(),
      loading: () => const _LoadingState(),
      loaded: (transfers) => _TransfersList(transfers: transfers),
      created: (_, transfers) => _TransfersList(transfers: transfers),
      error: (error) => ErrorStateWidget(
        message: NetworkExceptions.getErrorMessage(error),
        onRetry: () => context.read<TransferCubit>().loadTransfers(),
      ),
    );
  }
}

class _InitialState extends StatelessWidget {
  const _InitialState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pull to load transfers'),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
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
        icon: Icons.receipt_long_outlined,
        title: 'No Transfer Requests',
        message: 'You haven\'t created any transfer requests yet.\n'
            'Create your first one to get started!',
        actionLabel: 'Create Transfer',
        onActionPressed: () => context.push('/submit'),
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
