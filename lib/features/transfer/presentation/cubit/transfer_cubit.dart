import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sirius_transfer_app/core/cubit/safe_cubit.dart';
import 'package:sirius_transfer_app/core/errors/network_exceptions.dart';
import 'package:sirius_transfer_app/features/transfer/data/repositories/transfer_repository.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';

part 'transfer_state.dart';
part 'transfer_cubit.freezed.dart';

/// Cubit for managing transfer operations
///
/// Uses SafeCubit to prevent emitting after close
/// Uses injectable for dependency injection
@injectable
class TransferCubit extends SafeCubit<TransferState> {
  final TransferRepository transferRepository;

  List<TransferRequest> transfers = [];
  CancelToken? _cancelToken;

  TransferCubit(this.transferRepository) : super(const TransferState.initial());

  /// Load all transfers from repository
  Future<void> loadTransfers() async {
    _cancelToken = CancelToken();
    emit(const TransferState.loading());

    final response = await transferRepository.getTransfers(cancelToken: _cancelToken);

    response.fold(
      (error) => emit(TransferState.error(error: error)),
      (transfersList) {
        transfers = transfersList;
        emit(TransferState.loaded(transfers: transfers));
      },
    );
  }

  /// Create a new transfer
  Future<void> createNewTransfer({
    required String fromWallet,
    required String toWallet,
    required double amount,
    required String receiverName,
    required String receiverPhone,
    String? note,
  }) async {
    _cancelToken = CancelToken();
    emit(const TransferState.loading());

    final response = await transferRepository.createTransfer(
      fromWallet: fromWallet,
      toWallet: toWallet,
      amount: amount,
      receiverName: receiverName,
      receiverPhone: receiverPhone,
      note: note,
      cancelToken: _cancelToken,
    );

    response.fold(
      (error) => emit(TransferState.error(error: error)),
      (transfer) {
        transfers.insert(0, transfer);
        emit(TransferState.created(transfer: transfer, transfers: transfers));
      },
    );
  }

  /// Refresh transfers (alias for loadTransfers)
  Future<void> refreshTransfers() async {
    await loadTransfers();
  }

  /// Cancel ongoing requests
  void cancelRequest() {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel("Request cancelled by user");
    }
  }

  @override
  Future<void> close() {
    cancelRequest();
    return super.close();
  }
}
