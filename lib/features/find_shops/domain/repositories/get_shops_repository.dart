import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/shop.dart';

abstract class GetShopsRepository {
  Future<Either<Failure, List<Shop>>> getNearbyShops(double radius);
  Future<Either<Failure, List<Shop>>> getShopsInLocation(double latitude, double longitude, double radius);
}