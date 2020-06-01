import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/shop.dart';
import '../repositories/get_shops_repository.dart';

class GetNearbyShops extends UseCase<List<Shop>, double> {
  final GetShopsRepository _getShopsRepository;

  GetNearbyShops({@required GetShopsRepository repository})
      : assert(repository != null),
        _getShopsRepository = repository;

  @override
  Future<Either<Failure, List<Shop>>> call(double radius) {
    return _getShopsRepository.getNearbyShops(radius);
  }
}
