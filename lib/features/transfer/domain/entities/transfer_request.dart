import 'package:equatable/equatable.dart';

class TransferRequest extends Equatable {
  final String id;
  final String fromWallet;
  final String toWallet;
  final double amount;
  final String receiverName;
  final String receiverPhone;
  final String? note;
  final String status;
  final DateTime createdAt;

  const TransferRequest({
    required this.id,
    required this.fromWallet,
    required this.toWallet,
    required this.amount,
    required this.receiverName,
    required this.receiverPhone,
    this.note,
    required this.status,
    required this.createdAt,
  });

  // Calculate 2% fee
  double get fee => amount * 0.02;

  // Calculate total (amount + fee)
  double get total => amount + fee;

  @override
  List<Object?> get props => [
        id,
        fromWallet,
        toWallet,
        amount,
        receiverName,
        receiverPhone,
        note,
        status,
        createdAt,
      ];

  TransferRequest copyWith({
    String? id,
    String? fromWallet,
    String? toWallet,
    double? amount,
    String? receiverName,
    String? receiverPhone,
    String? note,
    String? status,
    DateTime? createdAt,
  }) {
    return TransferRequest(
      id: id ?? this.id,
      fromWallet: fromWallet ?? this.fromWallet,
      toWallet: toWallet ?? this.toWallet,
      amount: amount ?? this.amount,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
