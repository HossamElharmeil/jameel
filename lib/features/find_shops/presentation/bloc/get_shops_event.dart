import 'package:equatable/equatable.dart';

abstract class GetShopsEvent extends Equatable {
  const GetShopsEvent();
}

class NearbyShopsRequested extends GetShopsEvent {
  final double radius;

  NearbyShopsRequested(this.radius);
  @override
  List<Object> get props => [radius];
}

class ShopsInLocationRequested extends GetShopsEvent {
  final double latitude;
  final double longitude;
  final double radius;

  ShopsInLocationRequested(this.latitude, this.longitude, this.radius);
  @override
  List<Object> get props => [latitude, longitude, radius];
}
