import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/exceptions.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reservation/data/data_sources/firestore_reservation_data_source.dart';
import 'package:jameel/features/reservation/data/models/service_model.dart';
import 'package:jameel/features/reservation/data/repositories/reservation_repository_impl.dart';
import 'package:jameel/features/reservation/domain/entities/reservation.dart';
import 'package:jameel/features/reservation/domain/entities/service.dart';
import 'package:jameel/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:mockito/mockito.dart';

class MockFirestoreReservationDataSource extends Mock
    implements FirestoreReservationDataSource {}

void main() {
  ReservationDataSource mockFirestoreReservationDataSource;
  Reservation reservation;
  String userID;
  ReservationRepository repository;
  List<Reservation> reservations = [Reservation()];
  List<Service> servicesList;
  FirestoreException firestoreException;

  setUp(() {
    servicesList = [
      ServiceModel.fromJson({"name": "Hair cutting", "price": 15, "time": 30}),
    ];
    userID = '12345';

    mockFirestoreReservationDataSource = MockFirestoreReservationDataSource();
    repository = ReservationRepositoryImpl(
        dataSource: mockFirestoreReservationDataSource);
    reservation = Reservation(shopID: "Abo youssef");
    firestoreException = FirestoreException();
  });

  group("Get reservations tests", () {
    test(
        "should return the list of the reservations when the list of the reservations is returned by the data source",
        () async {
      when(mockFirestoreReservationDataSource.getReservations(any))
          .thenAnswer((_) async => reservations);

      final result = await repository.getReservations(userID);

      expect(result, Right(reservations));
      verify(mockFirestoreReservationDataSource.getReservations(userID));
    });

    test(
        "Should return a left of either with failure when data source throws exception",
        () async {
      when(mockFirestoreReservationDataSource.getReservations(any))
          .thenThrow(firestoreException);

      final result = await repository.getReservations(userID);

      verify(mockFirestoreReservationDataSource.getReservations(userID));
      expect(result,
          equals(Left(FirestoreFailure(firestoreException.toString()))));
    });
  });
  group("Make reservation tests", () {
    test("Should forward the reservation call to firestore data source",
        () async {
      await repository.makeReservation(reservation);

      verify(mockFirestoreReservationDataSource.makeReservation(reservation));
    });

    test("Should return a left of failure when data source throws exception",
        () async {
      when(mockFirestoreReservationDataSource.makeReservation(reservation))
          .thenThrow(firestoreException);

      final result = await repository.makeReservation(reservation);

      verify(mockFirestoreReservationDataSource.makeReservation(reservation));
      expect(result,
          equals(Left(FirestoreFailure(firestoreException.toString()))));
    });
  });
  group("Get services test", () {
    test(
        "should return the result of the data source get services when getServices is called with salonID",
        () async {
      when(mockFirestoreReservationDataSource.getServices(any))
          .thenAnswer((_) async => servicesList);

      final result = await repository.getServices("salonID");

      verify(mockFirestoreReservationDataSource.getServices("salonID"));
      expect(result, Right(servicesList));
    });

    test(
        "should return left of either with a firestore failure when the data source throws an error",
        () async {
      when(mockFirestoreReservationDataSource.getServices(any))
          .thenThrow(firestoreException);

      final result = await repository.getServices("salonID");

      verify(mockFirestoreReservationDataSource.getServices("salonID"));
      expect(result,
          equals(Left(FirestoreFailure(firestoreException.toString()))));
    });
  });
}
