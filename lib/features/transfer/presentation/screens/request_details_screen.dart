import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/config/app_constants.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';

class RequestDetailsScreen extends StatelessWidget {
  final TransferRequest transfer;

  const RequestDetailsScreen({
    super.key,
    required this.transfer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Request Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Status Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _getStatusColor(transfer.status).withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Icon(
                    _getStatusIcon(transfer.status),
                    size: 64,
                    color: _getStatusColor(transfer.status),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    transfer.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(transfer.status),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Transfer #${transfer.id}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Amount Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Transfer Amount',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppConstants.formatCurrency(transfer.amount),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      _DetailRow(
                        label: 'Fee (2%)',
                        value: AppConstants.formatCurrency(transfer.fee),
                      ),
                      const SizedBox(height: 12),
                      _DetailRow(
                        label: 'Total to Pay',
                        value: AppConstants.formatCurrency(transfer.total),
                        isHighlighted: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Wallets Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transfer Route',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _WalletCard(
                              label: 'From',
                              wallet: transfer.fromWallet,
                              icon: Icons.account_balance_wallet,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(
                              Icons.arrow_forward,
                              color: AppColors.primary,
                              size: 32,
                            ),
                          ),
                          Expanded(
                            child: _WalletCard(
                              label: 'To',
                              wallet: transfer.toWallet,
                              icon: Icons.account_balance,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Receiver Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Receiver Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _InfoRow(
                        icon: Icons.person,
                        label: 'Name',
                        value: transfer.receiverName,
                      ),
                      const SizedBox(height: 16),
                      _InfoRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: transfer.receiverPhone,
                      ),
                      if (transfer.note != null && transfer.note!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        _InfoRow(
                          icon: Icons.note,
                          label: 'Note',
                          value: transfer.note!,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'processing':
        return AppColors.primary;
      case 'failed':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'processing':
        return Icons.hourglass_empty;
      case 'failed':
        return Icons.error;
      default:
        return Icons.info;
    }
  }
}

// Detail row for amount breakdown
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlighted;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isHighlighted ? 16 : 14,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            color: isHighlighted ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlighted ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: isHighlighted ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// Wallet card widget
class _WalletCard extends StatelessWidget {
  final String label;
  final String wallet;
  final IconData icon;

  const _WalletCard({
    required this.label,
    required this.wallet,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            wallet,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// Information row widget
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
