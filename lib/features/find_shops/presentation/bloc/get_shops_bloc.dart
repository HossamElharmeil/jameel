import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import './bloc.dart';
import '../../domain/usecases/get_nearby_shops.dart';
import '../../domain/usecases/get_shops_in_location.dart';

class GetShopsBloc extends Bloc<GetShopsEvent, GetShopsState> {
  final GetNearbyShops _getNearbyShops;
  final GetShopsInLocation _getShopsInLocation;

  GetShopsBloc(
      {@required GetNearbyShops getNearbyShops,
      @required GetShopsInLocation getShopsInLocation})
      : assert(getNearbyShops != null),
        assert(getShopsInLocation != null),
        _getNearbyShops = getNearbyShops,
        _getShopsInLocation = getShopsInLocation;

  @override
  GetShopsState get initialState => GetShopsInitial();

  @override
  Stream<GetShopsState> mapEventToState(
    GetShopsEvent event,
  ) async* {
    if (event is NearbyShopsRequested) {
      yield* _mapGetNearbyShopsToState(event);
    }
    if (event is ShopsInLocationRequested) {
      yield* _mapShopsInLocationRequestedToState(event);
    }
  }

  Stream<GetShopsState> _mapGetNearbyShopsToState(
      NearbyShopsRequested event) async* {
    yield GetShopsInProgress();

    final getShopsEither = await _getNearbyShops(event.radius);

    yield* getShopsEither.fold(
      (failure) async* {
        yield GetShopsFail(failure);
      },
      (shopList) async* {
        yield GetShopsSuccess(shopList);
      },
    );
  }

  Stream<GetShopsState> _mapShopsInLocationRequestedToState(
      ShopsInLocationRequested event) async* {
    yield GetShopsInProgress();

    final either = await _getShopsInLocation(GetShopsInLocationParams(
        latitude: event.latitude,
        longitude: event.longitude,
        radius: event.radius));

    yield* either.fold(
      (failure) async* {
        yield GetShopsFail(failure);
      },
      (shopList) async* {
        yield GetShopsSuccess(shopList);
      },
    );
  }
}
