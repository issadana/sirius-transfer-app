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
      id: json['id'] as String,
      fromWallet: json['fromWallet'] as String,
      toWallet: json['toWallet'] as String,
      amount: (json['amount'] as num).toDouble(),
      receiverName: json['receiverName'] as String,
      receiverPhone: json['receiverPhone'] as String,
      note: json['note'] as String?,
      status: json['status'] as String,
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

  // Create from entity
  factory TransferRequestModel.fromEntity(TransferRequest entity) {
    return TransferRequestModel(
      id: entity.id,
      fromWallet: entity.fromWallet,
      toWallet: entity.toWallet,
      amount: entity.amount,
      receiverName: entity.receiverName,
      receiverPhone: entity.receiverPhone,
      note: entity.note,
      status: entity.status,
      createdAt: entity.createdAt,
    );
  }
}
