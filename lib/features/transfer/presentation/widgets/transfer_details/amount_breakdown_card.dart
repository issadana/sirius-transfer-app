import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/config/app_constants.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_details/detail_row.dart';

class AmountBreakdownCard extends StatelessWidget {
  final TransferRequest transfer;

  const AmountBreakdownCard({
    super.key,
    required this.transfer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            DetailRow(
              label: 'Fee (2%)',
              value: AppConstants.formatCurrency(transfer.fee),
            ),
            const SizedBox(height: 12),
            DetailRow(
              label: 'Total to Pay',
              value: AppConstants.formatCurrency(transfer.total),
              isHighlighted: true,
            ),
          ],
        ),
      ),
    );
  }
}
