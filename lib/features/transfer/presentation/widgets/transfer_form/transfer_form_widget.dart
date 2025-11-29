import 'package:flutter/material.dart';
import 'package:sirius_transfer_app/core/config/app_constants.dart';
import 'package:sirius_transfer_app/core/utils/validators.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/common/loading_button.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_form/fee_total_display.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_form/labeled_text_form_field.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_form/wallet_dropdown_field.dart';

class TransferForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final String? fromWallet;
  final String? toWallet;
  final TextEditingController amountController;
  final TextEditingController receiverNameController;
  final TextEditingController receiverPhoneController;
  final TextEditingController noteController;
  final ValueNotifier<double> feeNotifier;
  final ValueNotifier<double> totalNotifier;
  final ValueChanged<String?> onFromWalletChanged;
  final ValueChanged<String?> onToWalletChanged;
  final ValueChanged<String> onAmountChanged;
  final FormFieldValidator<String?> validateToWallet;
  final VoidCallback onSubmit;

  const TransferForm({
    required this.formKey,
    required this.isLoading,
    required this.fromWallet,
    required this.toWallet,
    required this.amountController,
    required this.receiverNameController,
    required this.receiverPhoneController,
    required this.noteController,
    required this.feeNotifier,
    required this.totalNotifier,
    required this.onFromWalletChanged,
    required this.onToWalletChanged,
    required this.onAmountChanged,
    required this.validateToWallet,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // From Wallet
            WalletDropdownField(
              label: 'From Wallet',
              value: fromWallet,
              hintText: 'Select source wallet',
              icon: Icons.account_balance_wallet,
              enabled: !isLoading,
              onChanged: onFromWalletChanged,
              validator: Validators.required('From Wallet'),
            ),
            const SizedBox(height: 16),

            // To Wallet
            WalletDropdownField(
              label: 'To Wallet',
              value: toWallet,
              hintText: 'Select destination wallet',
              icon: Icons.account_balance,
              enabled: !isLoading,
              onChanged: onToWalletChanged,
              validator: validateToWallet,
            ),
            const SizedBox(height: 16),

            // Amount
            LabeledTextFormField(
              label: 'Amount',
              controller: amountController,
              hintText: 'Enter amount',
              icon: Icons.attach_money,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              enabled: !isLoading,
              validator: Validators.amount,
              onChanged: onAmountChanged,
            ),
            const SizedBox(height: 16),

            // Fee and Total Display
            ValueListenableBuilder<double>(
              valueListenable: feeNotifier,
              builder: (context, fee, _) {
                return ValueListenableBuilder<double>(
                  valueListenable: totalNotifier,
                  builder: (context, total, _) {
                    return FeeTotalDisplay(
                      fee: fee,
                      total: total,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),

            // Receiver Name
            LabeledTextFormField(
              label: 'Receiver Name',
              controller: receiverNameController,
              hintText: 'Enter receiver name',
              icon: Icons.person,
              enabled: !isLoading,
              validator: Validators.name,
            ),
            const SizedBox(height: 16),

            // Receiver Phone
            LabeledTextFormField(
              label: 'Receiver Phone',
              controller: receiverPhoneController,
              hintText: '+961 XX XXX XXX',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              enabled: !isLoading,
              validator: Validators.phone,
            ),
            const SizedBox(height: 16),

            // Note (Optional)
            LabeledTextFormField(
              label: 'Note (Optional)',
              controller: noteController,
              hintText: 'Add a note',
              icon: Icons.note,
              enabled: !isLoading,
              maxLength: AppConstants.maxNoteLength,
            ),
            const SizedBox(height: 24),

            // Submit Button
            LoadingButton(
              onPressed: onSubmit,
              label: 'Submit Transfer',
              isLoading: isLoading,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
