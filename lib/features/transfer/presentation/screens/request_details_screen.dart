import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_details/amount_breakdown_card.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_details/receiver_info_card.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_details/status_header.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_details/transfer_route_card.dart';

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
            StatusHeader(status: transfer.status),
            const SizedBox(height: 24),

            // Amount Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AmountBreakdownCard(transfer: transfer),
            ),
            const SizedBox(height: 16),

            // Wallets Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TransferRouteCard(
                fromWallet: transfer.fromWallet,
                toWallet: transfer.toWallet,
              ),
            ),
            const SizedBox(height: 16),

            // Receiver Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ReceiverInfoCard(
                receiverName: transfer.receiverName,
                receiverPhone: transfer.receiverPhone,
                note: transfer.note,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
