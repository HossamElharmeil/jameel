import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final String name;
  final double price;
  final int time;

  Service({this.name, this.price, this.time});

  @override
  List<Object> get props => [name, price, time];
}
