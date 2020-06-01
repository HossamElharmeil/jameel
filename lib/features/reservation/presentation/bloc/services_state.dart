import 'package:equatable/equatable.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reservation/domain/entities/service.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
}

class ServicesInitial extends ServicesState {
  @override
  List<Object> get props => [];
}

class ServicesLoadInProgress extends ServicesState {
  @override
  List<Object> get props => [];
}

class ServicesLoadSuccess extends ServicesState {
  final List<Service> servicesList;

  ServicesLoadSuccess(this.servicesList);
  @override
  List<Object> get props => [servicesList];
}

class ServicesLoadFailure extends ServicesState {
  final Failure failure;

  ServicesLoadFailure(this.failure);
  @override
  List<Object> get props => [failure];
}
