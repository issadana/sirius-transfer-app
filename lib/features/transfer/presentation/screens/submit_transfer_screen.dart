import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius_transfer_app/core/config/app_constants.dart';
import 'package:sirius_transfer_app/core/errors/network_exceptions.dart';
import 'package:sirius_transfer_app/core/resources/app_colors.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:sirius_transfer_app/features/transfer/presentation/widgets/transfer_form/transfer_form_widget.dart';

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

  // ValueNotifiers for reactive calculations
  final _feeNotifier = ValueNotifier<double>(0.0);
  final _totalNotifier = ValueNotifier<double>(0.0);

  @override
  void dispose() {
    _amountController.dispose();
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    _noteController.dispose();
    _feeNotifier.dispose();
    _totalNotifier.dispose();
    super.dispose();
  }

  void _calculateFeeAndTotal() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    _feeNotifier.value = AppConstants.calculateFee(amount);
    _totalNotifier.value = AppConstants.calculateTotal(amount);
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

  String? _validateToWallet(String? value) {
    if (value == null || value.isEmpty) {
      return 'To Wallet is required';
    }
    if (value == _fromWallet) {
      return 'Source and destination must be different';
    }
    return null;
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
        listener: _handleStateChanges,
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return TransferForm(
            formKey: _formKey,
            isLoading: isLoading,
            fromWallet: _fromWallet,
            toWallet: _toWallet,
            amountController: _amountController,
            receiverNameController: _receiverNameController,
            receiverPhoneController: _receiverPhoneController,
            noteController: _noteController,
            feeNotifier: _feeNotifier,
            totalNotifier: _totalNotifier,
            onFromWalletChanged: (value) => setState(() => _fromWallet = value),
            onToWalletChanged: (value) => setState(() => _toWallet = value),
            onAmountChanged: (_) => _calculateFeeAndTotal(),
            validateToWallet: _validateToWallet,
            onSubmit: _submitTransfer,
          );
        },
      ),
    );
  }

  void _handleStateChanges(BuildContext context, TransferState state) {
    state.maybeWhen(
      created: (transfer, transfers) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transfer created successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pushReplacement('/details', extra: transfer);
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
  }
}
