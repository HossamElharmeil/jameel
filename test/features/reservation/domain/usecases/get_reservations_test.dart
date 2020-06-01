import 'package:dartz/dartz.dart';
import 'package:jameel/features/reservation/domain/entities/reservation.dart';
import 'package:jameel/features/reservation/domain/usecases/get_reservations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'make_reservation_test.dart';

void main() {
  MockReservationRepository mockReservationRepository;
  GetReservations getReservations;
  List<Reservation> reservations;
  GetReservationParams params;
  setUp(() {
    mockReservationRepository = MockReservationRepository();
    getReservations =
        GetReservations(reservationRepository: mockReservationRepository);
    params = GetReservationParams(userID: '12345');
  });

  test("Should get the reservation from the reservation repository", () async {
    when(mockReservationRepository.getReservations(any))
        .thenAnswer((_) async => Right(reservations));

    final result = await getReservations(params);

    expect(result, equals(Right(reservations)));
  });
}
