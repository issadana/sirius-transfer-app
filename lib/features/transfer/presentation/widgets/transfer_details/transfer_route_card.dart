import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';

class TransferRouteCard extends StatelessWidget {
  final String fromWallet;
  final String toWallet;

  const TransferRouteCard({
    super.key,
    required this.fromWallet,
    required this.toWallet,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: _WalletInfo(
                    label: 'From',
                    wallet: fromWallet,
                    icon: Icons.account_balance_wallet,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
                Expanded(
                  child: _WalletInfo(
                    label: 'To',
                    wallet: toWallet,
                    icon: Icons.account_balance,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletInfo extends StatelessWidget {
  final String label;
  final String wallet;
  final IconData icon;

  const _WalletInfo({
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
