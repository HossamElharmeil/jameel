import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:jameel/features/find_shops/domain/repositories/get_shops_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/shop.dart';

class GetShopsInLocation extends UseCase<List<Shop>, GetShopsInLocationParams> {
  final GetShopsRepository _getShopsRepository;

  GetShopsInLocation({@required GetShopsRepository repository})
      : assert(repository != null),
        _getShopsRepository = repository;

  @override
  Future<Either<Failure, List<Shop>>> call(
      GetShopsInLocationParams params) async {
    return await _getShopsRepository.getShopsInLocation(
        params.latitude, params.longitude, params.radius);
  }
}

class GetShopsInLocationParams {
  final double latitude;
  final double longitude;
  final double radius;

  GetShopsInLocationParams(
      {@required this.latitude,
      @required this.longitude,
      @required this.radius});
}
