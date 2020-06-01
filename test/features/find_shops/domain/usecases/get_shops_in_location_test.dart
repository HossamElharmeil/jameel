import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/find_shops/domain/entities/shop.dart';
import 'package:jameel/features/find_shops/domain/repositories/get_shops_repository.dart';
import 'package:jameel/features/find_shops/domain/usecases/get_shops_in_location.dart';
import 'package:mockito/mockito.dart';

const SEARCH_FAILURE = "Search query unsuccessful";

class MockGetShopsRepository extends Mock implements GetShopsRepository {}

void main() {
  GetShopsRepository mockGetShopsRepository;
  GetShopsInLocation getShopsInLocation;
  List<Shop> tShopList = [Shop(shopID: 'test shop')];
  double radius = 25.0;
  double latitude = 30.80;
  double longitude = 30.96;

  setUp(() {
    mockGetShopsRepository = MockGetShopsRepository();
    getShopsInLocation = GetShopsInLocation(repository: mockGetShopsRepository);
  });

  test(
      'should forward the call to the repository to get the nearby shops when called and return the result',
      () async {
    when(mockGetShopsRepository.getShopsInLocation(any, any, any))
        .thenAnswer((_) async => Right(tShopList));

    final result = await getShopsInLocation(GetShopsInLocationParams(latitude: latitude, longitude: longitude, radius: radius));

    verify(mockGetShopsRepository.getShopsInLocation(latitude, longitude, radius));
    expect(result, Right(tShopList));
  });

  test(
    'should return a left containing failure wden returned by the repository',
    () async {
      when(mockGetShopsRepository.getShopsInLocation(any, any, any))
          .thenAnswer((_) async => Left(SearchFailure(SEARCH_FAILURE)));

      final result = await getShopsInLocation(GetShopsInLocationParams(latitude: latitude, longitude: longitude, radius: radius));

      verify(mockGetShopsRepository.getShopsInLocation(latitude, longitude, radius));
      expect(result, Left(SearchFailure(SEARCH_FAILURE)));
    },
  );
}
