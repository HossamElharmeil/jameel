import 'package:jameel/features/find_shops/domain/entities/shop.dart';

class ShopModel extends Shop {
  final String shopID;
  final Map position;
  final String name;

  ShopModel({this.shopID, this.position, this.name});

  factory ShopModel.fromJson(Map<String, dynamic> map) {
    return ShopModel(
      name: map['name'],
      position: map['position'],
      shopID: map['shopID'],
    );
  }
}
