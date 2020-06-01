import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reservation/data/models/service_model.dart';
import 'package:jameel/features/reservation/domain/entities/service.dart';
import 'package:jameel/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:jameel/features/reservation/domain/usecases/get_services.dart';
import 'package:mockito/mockito.dart';

class MockReservationRepository extends Mock implements ReservationRepository {}

void main() {
  ReservationRepository reservationRepository;
  GetServices getServices;
  List<Service> servicesList;

  setUp(() {
    reservationRepository = MockReservationRepository();
    getServices = GetServices(reservationRepository: reservationRepository);
    servicesList = [
      ServiceModel.fromJson({"name": "Hair cutting", "price": 15, "time": 30}),
    ];
  });

  test(
      "should return getServices from the reservation repository with the salon id",
      () async {
    when(reservationRepository.getServices(any))
        .thenAnswer((_) async => Right(servicesList));

    final result = await getServices("salonID");

    verify(reservationRepository.getServices("salonID"));
    expect(result, Right(servicesList));
  });

  test("should return failure when the repository returns left of failure", () async {
    when(reservationRepository.getServices(any)).thenAnswer(
        (_) async => Left(FirestoreFailure("could not get services")));

    final result = await getServices("salonID");

    verify(reservationRepository.getServices("salonID"));
    expect(result, Left(FirestoreFailure("could not get services")));
  });
}
