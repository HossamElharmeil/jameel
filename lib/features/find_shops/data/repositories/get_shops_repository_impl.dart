import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/shop.dart';
import '../../domain/repositories/get_shops_repository.dart';
import '../data_sources/get_shops_data_source.dart';

const SEARCH_FAILURE = "Search query unsuccessful";

class GetShopsRepositoryImpl implements GetShopsRepository {
  final GetShopsDataSource _getShopsDataSource;

  GetShopsRepositoryImpl({GetShopsDataSource dataSource})
      : assert(dataSource != null),
        _getShopsDataSource = dataSource;

  @override
  Future<Either<Failure, List<Shop>>> getNearbyShops(double radius) async {
    try {
      final nearbyShops = await _getShopsDataSource.getNearbyShops(radius);
      return Right(nearbyShops);
    } catch (e) {
      return Left(SearchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Shop>>> getShopsInLocation(
      double latitude, double longitude, double radius) async {
    try {
      return Right(await _getShopsDataSource.getShopsInLocation(
          latitude, longitude, radius));
    } catch (e) {
      return Left(SearchFailure(e.toString()));
    }
  }
}
