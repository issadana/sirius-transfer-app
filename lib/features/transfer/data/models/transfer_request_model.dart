import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';

// Data model that extends the entity
class TransferRequestModel extends TransferRequest {
  const TransferRequestModel({
    required super.id,
    required super.fromWallet,
    required super.toWallet,
    required super.amount,
    required super.receiverName,
    required super.receiverPhone,
    super.note,
    required super.status,
    required super.createdAt,
  });

  // Create from JSON
  factory TransferRequestModel.fromJson(Map<String, dynamic> json) {
    return TransferRequestModel(
      id: json['id'] ?? "",
      fromWallet: json['fromWallet'] ?? "",
      toWallet: json['toWallet'] ?? "",
      amount: (json['amount'] ?? 0).toDouble(),
      receiverName: json['receiverName'] ?? "",
      receiverPhone: json['receiverPhone'] ?? "",
      note: json['note'] ?? "",
      status: json['status'] ?? "",
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromWallet': fromWallet,
      'toWallet': toWallet,
      'amount': amount,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'note': note,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
