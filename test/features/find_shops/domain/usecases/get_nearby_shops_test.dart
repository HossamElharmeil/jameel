import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/find_shops/domain/entities/shop.dart';
import 'package:jameel/features/find_shops/domain/repositories/get_shops_repository.dart';
import 'package:jameel/features/find_shops/domain/usecases/get_nearby_shops.dart';
import 'package:mockito/mockito.dart';

const SEARCH_FAILURE = "Search query unsuccessful";

class MockGetShopsRepository extends Mock implements GetShopsRepository {}

void main() {
  GetShopsRepository mockGetShopsRepository;
  GetNearbyShops getNearbyShops;
  List<Shop> tShopList = [Shop(shopID: 'test shop')];
  double radius = 25.0;

  setUp(() {
    mockGetShopsRepository = MockGetShopsRepository();
    getNearbyShops = GetNearbyShops(repository: mockGetShopsRepository);
  });

  test(
      'should forward the call to the repository to get the nearby shops when called and return the result',
      () async {
    when(mockGetShopsRepository.getNearbyShops(any))
        .thenAnswer((_) async => Right(tShopList));

    final result = await getNearbyShops(radius);

    verify(mockGetShopsRepository.getNearbyShops(radius));
    expect(result, Right(tShopList));
  });

  test(
    'should return a left containing failure wden returned by the repository',
    () async {
      when(mockGetShopsRepository.getNearbyShops(any))
          .thenAnswer((_) async => Left(SearchFailure(SEARCH_FAILURE)));

      final result = await getNearbyShops(radius);

      verify(mockGetShopsRepository.getNearbyShops(radius));
      expect(result, Left(SearchFailure(SEARCH_FAILURE)));
    },
  );
}
