import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius_transfer_app/core/config/app_constants.dart';
import 'package:sirius_transfer_app/core/errors/network_exceptions.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';
import 'package:sirius_transfer_app/core/utils/validators.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/cubit/transfer_cubit.dart';

class SubmitTransferScreen extends StatefulWidget {
  const SubmitTransferScreen({super.key});

  @override
  State<SubmitTransferScreen> createState() => _SubmitTransferScreenState();
}

class _SubmitTransferScreenState extends State<SubmitTransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _receiverNameController = TextEditingController();
  final _receiverPhoneController = TextEditingController();
  final _noteController = TextEditingController();

  String? _fromWallet;
  String? _toWallet;
  double _fee = 0.0;
  double _total = 0.0;

  @override
  void dispose() {
    _amountController.dispose();
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _calculateFeeAndTotal() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      _fee = AppConstants.calculateFee(amount);
      _total = AppConstants.calculateTotal(amount);
    });
  }

  void _submitTransfer() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);

      context.read<TransferCubit>().createNewTransfer(
            fromWallet: _fromWallet!,
            toWallet: _toWallet!,
            amount: amount,
            receiverName: _receiverNameController.text.trim(),
            receiverPhone: _receiverPhoneController.text.trim(),
            note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Submit Transfer'),
        centerTitle: true,
      ),
      body: BlocConsumer<TransferCubit, TransferState>(
        listener: (context, state) {
          state.maybeWhen(
            created: (transfer, transfers) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Transfer created successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
              context.go('/');
            },
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(NetworkExceptions.getErrorMessage(error)),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // From Wallet Dropdown
                  const Text(
                    'From Wallet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _fromWallet,
                    decoration: InputDecoration(
                      hintText: 'Select source wallet',
                      prefixIcon: const Icon(Icons.account_balance_wallet),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: AppConstants.wallets
                        .map((wallet) => DropdownMenuItem(
                              value: wallet,
                              child: Text(wallet),
                            ))
                        .toList(),
                    onChanged: isLoading ? null : (value) => setState(() => _fromWallet = value),
                    validator: Validators.required('From Wallet'),
                  ),

                  const SizedBox(height: 16),

                  // To Wallet Dropdown
                  const Text(
                    'To Wallet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _toWallet,
                    decoration: InputDecoration(
                      hintText: 'Select destination wallet',
                      prefixIcon: const Icon(Icons.account_balance),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: AppConstants.wallets
                        .map((wallet) => DropdownMenuItem(
                              value: wallet,
                              child: Text(wallet),
                            ))
                        .toList(),
                    onChanged: isLoading ? null : (value) => setState(() => _toWallet = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'To Wallet is required';
                      }
                      if (value == _fromWallet) {
                        return 'Source and destination must be different';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Amount Field
                  const Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (_) => _calculateFeeAndTotal(),
                    validator: Validators.amount,
                  ),

                  const SizedBox(height: 16),

                  // Fee and Total Display
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Fee (2%)',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              AppConstants.formatCurrency(_fee),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total to Pay',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              AppConstants.formatCurrency(_total),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Receiver Name
                  const Text(
                    'Receiver Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _receiverNameController,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      hintText: 'Enter receiver name',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: Validators.name,
                  ),

                  const SizedBox(height: 16),

                  // Receiver Phone
                  const Text(
                    'Receiver Phone',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _receiverPhoneController,
                    keyboardType: TextInputType.phone,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      hintText: '+961 XX XXX XXX',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: Validators.phone,
                  ),

                  const SizedBox(height: 16),

                  // Note (Optional)
                  const Text(
                    'Note (Optional)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _noteController,
                    enabled: !isLoading,
                    maxLength: AppConstants.maxNoteLength,
                    decoration: InputDecoration(
                      hintText: 'Add a note',
                      prefixIcon: const Icon(Icons.note),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitTransfer,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Submit Transfer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
