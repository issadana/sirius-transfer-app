import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sirius_transfer_app/core/api/api_consumer.dart';
import 'package:sirius_transfer_app/core/errors/network_exceptions.dart';
import 'package:sirius_transfer_app/features/transfer/data/models/transfer_request_model.dart';
import 'package:sirius_transfer_app/features/transfer/domain/entities/transfer_request.dart';

// Repository implementation for transfer operations
@injectable
class TransferRepository {
  final ApiConsumer apiConsumer;

  TransferRepository({required this.apiConsumer});

  // Get all transfers
  Future<Either<NetworkExceptions, List<TransferRequest>>> getTransfers({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await apiConsumer.get(
        '/transfers',
        cancelToken: cancelToken,
      );

      final List<dynamic> data = jsonDecode(response);
      final transfers = data.map((json) => TransferRequestModel.fromJson(json)).toList();

      return Right(transfers);
    } catch (error) {
      return Left(NetworkExceptions.getException(error));
    }
  }

  // Create a new transfer
  Future<Either<NetworkExceptions, TransferRequest>> createTransfer({
    required String fromWallet,
    required String toWallet,
    required double amount,
    required String receiverName,
    required String receiverPhone,
    String? note,
    CancelToken? cancelToken,
  }) async {
    try {
      final body = {
        'fromWallet': fromWallet,
        'toWallet': toWallet,
        'amount': amount,
        'receiverName': receiverName,
        'receiverPhone': receiverPhone,
        'note': note,
      };

      final response = await apiConsumer.post(
        '/transfers',
        body: body,
        cancelToken: cancelToken,
      );

      final transfer = TransferRequestModel.fromJson(jsonDecode(response));
      return Right(transfer);
    } catch (error) {
      return Left(NetworkExceptions.getException(error));
    }
  }

  // Get transfer by ID
  Future<Either<NetworkExceptions, TransferRequest>> getTransferById({
    required String id,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await apiConsumer.get(
        '/transfers/$id',
        cancelToken: cancelToken,
      );

      final transfer = TransferRequestModel.fromJson(jsonDecode(response));
      return Right(transfer);
    } catch (error) {
      return Left(NetworkExceptions.getException(error));
    }
  }
}
