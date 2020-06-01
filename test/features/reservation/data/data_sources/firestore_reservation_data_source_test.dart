import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/features/reservation/data/models/reservation_model.dart';
import 'package:jameel/features/reservation/data/models/service_model.dart';
import 'package:jameel/features/reservation/domain/entities/reservation.dart';
import 'package:jameel/features/reservation/domain/entities/service.dart';
import 'package:mockito/mockito.dart';
import 'package:jameel/features/reservation/data/data_sources/firestore_reservation_data_source.dart';
import 'package:jameel/core/error/exceptions.dart';
import 'package:matcher/matcher.dart';

class MockFirestoreWrapper extends Mock implements FirestoreWrapper {}

void main() {
  Reservation reservation;
  String userID;
  List<Reservation> list;
  List<Service> servicesList;
  FirestoreWrapper wrapper;
  FirestoreReservationDataSource dataSource;

  setUp(() {
    userID = '12345';
    list = [];
    reservation = ReservationModel(
        dateTime: DateTime(1998), userID: userID, shopID: 'abo hassan');
    wrapper = MockFirestoreWrapper();
    dataSource = FirestoreReservationDataSource(wrapper: wrapper);
    servicesList = [
      ServiceModel.fromJson({"name": "Hair cutting", "price": 15, "time": 30}),
    ];
  });

  group('Get reservations tests', () {
    test(
        'should forward the call to firestore wrapper and return the output when get reservations is called',
        () async {
      when(wrapper.getReservations(any)).thenAnswer((_) async => list);

      final result = await dataSource.getReservations(userID);

      verify(wrapper.getReservations(userID));
      expect(result, list);
    });

    test(
        'should return a the exception when the wrapper throws an exception',
        () {
      when(wrapper.getReservations(any)).thenThrow(FirestoreException());

      expect(dataSource.getReservations(userID),
          throwsA(TypeMatcher<FirestoreException>()));
    });
  });

  group('Make reservation test', () {
    test(
        'should forward the call to the wrapper when make reservation is called',
        () async {
      await dataSource.makeReservation(reservation);

      verify(wrapper.makeReservation(reservation));
    });

    test(
        'should throw FirestoreException when the wrapper call is unsuccessful',
        () {
      when(wrapper.makeReservation(any)).thenThrow(FirestoreException());

      expect(dataSource.makeReservation(reservation),
          throwsA(TypeMatcher<FirestoreException>()));
    });
  });

  group("Get services test", () {
    test(
        "should return the result from firestore wrapper when get services is called with salonID",
        () async {
      when(wrapper.getServices(any)).thenAnswer((_) async => servicesList);

      final result = await dataSource.getServices("salonID");

      verify(wrapper.getServices("salonID"));
      expect(result, servicesList);
    });

    test(
        "should throw a firestore exception when the wrapper trows an exception",
        () {
      when(wrapper.getServices(any)).thenThrow(FirestoreException());

      expect(dataSource.getServices("salonID"), throwsA(TypeMatcher<FirestoreException>()));
    });
  });
}
