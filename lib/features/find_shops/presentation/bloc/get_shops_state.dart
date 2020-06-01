import 'package:equatable/equatable.dart';
import 'package:jameel/core/error/failures.dart';

import '../../domain/entities/shop.dart';

abstract class GetShopsState extends Equatable {
  const GetShopsState();
}

class GetShopsInitial extends GetShopsState {
  @override
  List<Object> get props => [];
}

class GetShopsInProgress extends GetShopsState {
  @override
  List<Object> get props => [];
}

class GetShopsSuccess extends GetShopsState {
  final List<Shop> shopList;

  GetShopsSuccess(this.shopList);
  @override
  List<Object> get props => [shopList];
}

class GetShopsFail extends GetShopsState {
  final Failure failure;

  GetShopsFail(this.failure);
  @override
  List<Object> get props => [failure];
}
