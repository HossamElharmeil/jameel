import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/find_shops/domain/entities/shop.dart';
import 'package:jameel/features/find_shops/domain/usecases/get_nearby_shops.dart';
import 'package:jameel/features/find_shops/domain/usecases/get_shops_in_location.dart';
import 'package:jameel/features/find_shops/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

const SEARCH_FAILURE = "Search query unsuccessful";

class MockGetNearbyShops extends Mock implements GetNearbyShops {}

class MockGetShopsInLocation extends Mock implements GetShopsInLocation {}

void main() {
  GetNearbyShops mockGetNearbyShops;
  GetShopsInLocation mockGetShopsInLocation;
  GetShopsBloc getShopsBloc;
  List<Shop> testShopList = [Shop(name: 'test shop')];
  double radius = 25.0;
  double latitude = 30.80;
  double longitude = 30.96;

  setUp(() {
    mockGetNearbyShops = MockGetNearbyShops();
    mockGetShopsInLocation = MockGetShopsInLocation();
    getShopsBloc = GetShopsBloc(
        getNearbyShops: mockGetNearbyShops,
        getShopsInLocation: mockGetShopsInLocation);
  });

  group('GetNearbyShops test', () {
    blocTest(
      'should emit GetShopsInitial, GetShopsInProgress and GetShopsSuccess when GetNearbyShops returns a Right type',
      build: () {
        when(mockGetNearbyShops(any))
            .thenAnswer((_) async => Right(testShopList));
        return getShopsBloc;
      },
      act: (bloc) async {
        await bloc.add(NearbyShopsRequested(radius));
      },
      expect: [
        GetShopsInitial(),
        GetShopsInProgress(),
        GetShopsSuccess(testShopList),
      ],
    );

    blocTest(
      'should emit GetShopsInitial, GetShopsInProgress and GetShopsFail when GetNearbyShops returns a Left type',
      build: () {
        when(mockGetNearbyShops(any))
            .thenAnswer((_) async => Left(SearchFailure(SEARCH_FAILURE)));
        return getShopsBloc;
      },
      act: (bloc) async {
        await bloc.add(NearbyShopsRequested(radius));
      },
      expect: [
        GetShopsInitial(),
        GetShopsInProgress(),
        GetShopsFail(SearchFailure(SEARCH_FAILURE)),
      ],
    );
  });

  group('GetShopsInLocation test', () {
    blocTest(
      'should emit GetShopsInitial, GetShopsInProgress and GetShopsSuccess when GetShopsInLocation returns a Right type',
      build: () {
        when(mockGetShopsInLocation(any))
            .thenAnswer((_) async => Right(testShopList));
        return getShopsBloc;
      },
      act: (bloc) async {
        await bloc.add(ShopsInLocationRequested(latitude, longitude, radius));
      },
      expect: [
        GetShopsInitial(),
        GetShopsInProgress(),
        GetShopsSuccess(testShopList),
      ],
    );

    blocTest(
      'should emit GetShopsInitial, GetShopsInProgress and GetShopsFail when GetShopsInLocation returns a Left type',
      build: () {
        when(mockGetShopsInLocation(any))
            .thenAnswer((_) async => Left(SearchFailure(SEARCH_FAILURE)));
        return getShopsBloc;
      },
      act: (bloc) async {
        await bloc.add(ShopsInLocationRequested(latitude, longitude, radius));
      },
      expect: [
        GetShopsInitial(),
        GetShopsInProgress(),
        GetShopsFail(SearchFailure(SEARCH_FAILURE)),
      ],
    );
  });
}
