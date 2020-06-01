import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reservation/data/models/service_model.dart';
import 'package:jameel/features/reservation/domain/usecases/get_services.dart';
import 'package:jameel/features/reservation/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

const String FIRESTORE_FAILURE = 'Could not get services';

class MockGetServices extends Mock implements GetServices {}

void main() {
  MockGetServices mockGetServices;
  String salonID;

  setUp(() {
    mockGetServices = MockGetServices();
    salonID = "salonID";
  });

  group("GetServices test", () {
    blocTest(
      "should emit initial state when initialized",
      build: () {
        return ServicesBloc(getServices: mockGetServices);
      },
      expect: [ServicesInitial()],
    );

    blocTest(
      "should emit ServicesLoadInProgress and ServicesLoadSuccess when ServicesRequested is added",
      build: () {
        when(mockGetServices(any)).thenAnswer((_) async => Right([
              ServiceModel.fromJson(
                  {"name": "Hair cutting", "price": 15, "time": 30}),
            ]));
        return ServicesBloc(getServices: mockGetServices);
      },
      act: (bloc) async {
        bloc.add(ServicesRequested(salonID));
      },
      expect: [
        ServicesInitial(),
        ServicesLoadInProgress(),
        ServicesLoadSuccess([
          ServiceModel.fromJson(
              {"name": "Hair cutting", "price": 15, "time": 30}),
        ]),
      ],
    );

    blocTest(
      "should emit ServicesLoadInProgress and ServicesLoadFailure when the GetServices returns a left of either",
      build: () {
        when(mockGetServices(any))
            .thenAnswer((_) async => Left(FirestoreFailure(FIRESTORE_FAILURE)));
        return ServicesBloc(getServices: mockGetServices);
      },
      act: (bloc) async {
        bloc.add(ServicesRequested(salonID));
      },
      expect: [
        ServicesInitial(),
        ServicesLoadInProgress(),
        ServicesLoadFailure(FirestoreFailure(FIRESTORE_FAILURE)),
      ],
    );
  });
}
