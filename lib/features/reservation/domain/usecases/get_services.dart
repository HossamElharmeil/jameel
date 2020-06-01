import 'package:dartz/dartz.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/core/usecase.dart';
import 'package:jameel/features/reservation/domain/entities/service.dart';
import 'package:jameel/features/reservation/domain/repositories/reservation_repository.dart';

class GetServices extends UseCase<List, String> {
  final ReservationRepository reservationRepository;

  GetServices({this.reservationRepository});

  @override
  Future<Either<Failure, List<Service>>> call(String salonID) {
    return reservationRepository.getServices(salonID);
  }
}
