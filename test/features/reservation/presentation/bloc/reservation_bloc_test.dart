import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reservation/domain/entities/reservation.dart';
import 'package:jameel/features/reservation/domain/usecases/get_reservations.dart';
import 'package:jameel/features/reservation/domain/usecases/make_reservation.dart';
import 'package:jameel/features/reservation/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc/bloc.dart';

class MockGetReservations extends Mock implements GetReservations {}

class MockMakeReservation extends Mock implements MakeReservation {}

void main() {
  GetReservations mockGetReservations;
  Reservation reservation;
  MakeReservation mockMakeReservation;
  Bloc reservationBloc;
  final List<Reservation> list = [
    Reservation(
        shopID: 'salon', userID: 'userID', dateTime: DateTime(1998, 9, 9))
  ];
  setUp(() {
    mockGetReservations = MockGetReservations();
    mockMakeReservation = MockMakeReservation();
    reservation = Reservation(
        dateTime: DateTime(1998, 12, 1), userID: 'userID', shopID: "Beautify");

    reservationBloc = ReservationBloc(
        getReservations: mockGetReservations,
        makeReservation: mockMakeReservation);
  });

  group('Get Reservations test', () {
    blocTest(
      'Should emit initial state when started',
      build: () {
        return reservationBloc;
      },
      expect: [ReservationsInitial()],
    );

    blocTest(
      'should emit error state when the reservation call fails',
      build: () {
        when(mockGetReservations(any)).thenAnswer((_) async =>
            Left(FirestoreFailure("Could not get reservations list")));
        return reservationBloc;
      },
      act: (bloc) {
        return bloc.add(ReservationsRequested('userID'));
      },
      expect: [
        ReservationsInitial(),
        ReservationsLoadInProgress(),
        ReservationsLoadFailure("Could not get reservations list")
      ],
    );

    blocTest(
      'should return ReservationsLoadSucess when the use case returns a list of reservationsList',
      build: () {
        when(mockGetReservations(any)).thenAnswer((_) async => Right(list));
        return reservationBloc;
      },
      act: (bloc) async {
        bloc.add(ReservationsRequested('userID'));
      },
      expect: [
        ReservationsInitial(),
        ReservationsLoadInProgress(),
        ReservationsLoadSuccess(list),
      ],
    );
  });

  test(
    'should forward the call to the MakeReservation usecase when ReservationSubmitted is added',
    () async {
      when(mockMakeReservation(any)).thenAnswer((_) async => Right(true));

      reservationBloc.add(ReservationSubmitted(reservation));
      await untilCalled(mockMakeReservation(reservation));

      verify(mockMakeReservation(reservation));
    },
  );
}
