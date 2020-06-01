import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  final String shopID;
  final Map position;
  final String name;

  Shop({this.shopID, this.position, this.name});

  @override
  List<Object> get props => [shopID, position, name];
}
