import 'package:dartz/dartz.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reservation/domain/entities/reservation.dart';
import 'package:jameel/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:jameel/features/reservation/domain/usecases/make_reservation.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockReservationRepository extends Mock implements ReservationRepository {}

void main() {
  Reservation reservation;
  MockReservationRepository mockReservationRepository;
  MakeReservation makeReservation;
  RepositoryFailure failure;

  setUp(() {
    reservation = Reservation(
      shopID: "Nader",
      userID: '123456',
    );
    mockReservationRepository = MockReservationRepository();
    makeReservation = MakeReservation(
      reservationRepository: mockReservationRepository,
    );
  });

  test("should throw an error when repository throws an error", () async {
    when(mockReservationRepository.makeReservation(any))
        .thenAnswer((_) async => Left(failure));

    final result = await makeReservation(reservation);

    expect(result, Left(failure));
  });

  test(
      "should forward the call to the repository when MakeReservation is called with a user and a reservation",
      () async {
    await makeReservation(reservation);

    verify(mockReservationRepository.makeReservation(reservation));
  });
}
