import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/exceptions.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/find_shops/data/data_sources/get_shops_data_source.dart';
import 'package:jameel/features/find_shops/data/repositories/get_shops_repository_impl.dart';
import 'package:jameel/features/find_shops/domain/entities/shop.dart';
import 'package:jameel/features/find_shops/domain/repositories/get_shops_repository.dart';
import 'package:mockito/mockito.dart';

const SEARCH_FAILURE = "Search query unsuccessful";

class MockGetShopsDataSource extends Mock implements GetShopsDataSource {}

void main() {
  GetShopsDataSource mockDataSource;
  GetShopsRepository repository;
  double radius = 25.0;
  double latitude = 30.80;
  double longitude = 30.96;
  List<Shop> tShopList = [Shop(name: 'test shop')];

  setUp(() {
    mockDataSource = MockGetShopsDataSource();
    repository = GetShopsRepositoryImpl(dataSource: mockDataSource);
  });

  group('GetNearbyShops test', () {
    test(
      'should forward the call to the data source with the correct radius to get shops',
      () async {
        when(mockDataSource.getNearbyShops(radius))
            .thenAnswer((_) async => tShopList);

        final result = await repository.getNearbyShops(radius);

        verify(mockDataSource.getNearbyShops(radius));
        expect(result, Right(tShopList));
      },
    );
    test(
      'should return a left containing a failure when the call to the data source is unsuccessful',
      () async {
        final exception = SearchException();

        when(mockDataSource.getNearbyShops(radius)).thenThrow(exception);

        final result = await repository.getNearbyShops(radius);

        verify(mockDataSource.getNearbyShops(radius));
        expect(result, Left(SearchFailure(exception.toString())));
      },
    );
  });

  group('GetShopsInLocation test', () {
    test(
      'should forward the call to the data source with the correct latitude, longitude and radius to get shops',
      () async {
        when(mockDataSource.getShopsInLocation(latitude, longitude, radius))
            .thenAnswer((_) async => tShopList);

        final result =
            await repository.getShopsInLocation(latitude, longitude, radius);

        verify(mockDataSource.getShopsInLocation(latitude, longitude, radius));
        expect(result, Right(tShopList));
      },
    );

    test(
      'should return a left containing a failure when the call to the data source is unsuccessful',
      () async {
        final exception = SearchException();

        when(mockDataSource.getShopsInLocation(latitude, longitude, radius)).thenThrow(exception);

        final result = await repository.getShopsInLocation(latitude, longitude, radius);

        verify(mockDataSource.getShopsInLocation(latitude, longitude, radius));
        expect(result, Left(SearchFailure(exception.toString())));
      },
    );
  });
}
