import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/config/app_constants.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';
import 'package:sirius_transfer_app/core/utils/date_formatter.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_card/status_chip.dart';

class TransferCard extends StatelessWidget {
  final TransferRequest transfer;
  final VoidCallback? onTap;

  const TransferCard({
    super.key,
    required this.transfer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TransferCardHeader(transfer: transfer),
              const SizedBox(height: 16),
              _TransferCardAmount(transfer: transfer),
              const SizedBox(height: 16),
              _TransferCardReceiverInfo(transfer: transfer),
              if (transfer.note != null && transfer.note!.isNotEmpty) ...[
                const SizedBox(height: 12),
                _TransferCardNote(note: transfer.note!),
              ],
              const SizedBox(height: 12),
              _TransferCardDate(date: transfer.createdAt),
            ],
          ),
        ),
      ),
    );
  }
}

// Header section with wallet information and status
class _TransferCardHeader extends StatelessWidget {
  final TransferRequest transfer;

  const _TransferCardHeader({required this.transfer});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _WalletBadge(wallet: transfer.fromWallet),
        const SizedBox(width: 8),
        const Icon(
          Icons.arrow_forward,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 8),
        _WalletBadge(wallet: transfer.toWallet),
        const Spacer(),
        StatusChip(status: transfer.status),
      ],
    );
  }
}

// Wallet badge widget
class _WalletBadge extends StatelessWidget {
  final String wallet;

  const _WalletBadge({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        wallet,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

// Amount section with fee and total
class _TransferCardAmount extends StatelessWidget {
  final TransferRequest transfer;

  const _TransferCardAmount({required this.transfer});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Amount',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppConstants.formatCurrency(transfer.amount),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Fee: ${AppConstants.formatCurrency(transfer.fee)}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: ${AppConstants.formatCurrency(transfer.total)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Receiver information section
class _TransferCardReceiverInfo extends StatelessWidget {
  final TransferRequest transfer;

  const _TransferCardReceiverInfo({required this.transfer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow(
          icon: Icons.person_outline,
          text: transfer.receiverName,
        ),
        const SizedBox(height: 8),
        _InfoRow(
          icon: Icons.phone_outlined,
          text: transfer.receiverPhone,
        ),
      ],
    );
  }
}

// Info row with icon and text
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

// Note section
class _TransferCardNote extends StatelessWidget {
  final String note;

  const _TransferCardNote({required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.note_outlined,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Date section
class _TransferCardDate extends StatelessWidget {
  final DateTime date;

  const _TransferCardDate({required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          size: 14,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          DateFormatter.formatRelative(date),
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
