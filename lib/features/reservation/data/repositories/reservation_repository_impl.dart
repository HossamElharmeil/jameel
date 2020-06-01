import 'package:dartz/dartz.dart';
import 'package:jameel/features/reservation/domain/entities/service.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../data_sources/firestore_reservation_data_source.dart';

const String FIRESTORE_EXCEPTION = "Firestore threw an exception";

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationDataSource dataSource;

  ReservationRepositoryImpl({@required this.dataSource});

  @override
  Future<Either<Failure, bool>> makeReservation(Reservation reservation) async {
    try {
      await dataSource.makeReservation(reservation);
      return Right(true);
    } catch(e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> getReservations(
      String userID) async {
    try {
      final result = await dataSource.getReservations(userID);
      return Right(result);
    } catch(e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getServices(String shopID) async {
    try {
      final result = await dataSource.getServices(shopID);
      return Right(result);
    } catch(e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }
}
