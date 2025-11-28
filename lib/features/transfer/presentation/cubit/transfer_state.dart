part of 'transfer_cubit.dart';

@freezed
class TransferState with _$TransferState {
  const factory TransferState.initial() = _Initial;
  const factory TransferState.loading() = _Loading;
  const factory TransferState.loaded({required List<TransferRequest> transfers}) = _Loaded;
  const factory TransferState.created({required TransferRequest transfer, required List<TransferRequest> transfers}) =
      _Created;
  const factory TransferState.error({required NetworkExceptions error}) = _Error;
}
