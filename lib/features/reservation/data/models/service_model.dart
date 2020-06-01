import 'package:jameel/features/reservation/domain/entities/service.dart';

class ServiceModel extends Service {
  final String name;
  final double price;
  final int time;

  ServiceModel({this.name, this.price, this.time})
      : super(name: name, price: price, time: time);

  factory ServiceModel.fromJson(Map<String, dynamic> map) {
    return ServiceModel(
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      time: (map['time'] as num).toInt(),
    );
  }
}
