import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/features/find_shops/data/models/shop_model.dart';

void main() {
  ShopModel shopModel;
  Map<String, dynamic> testMap = {
    'name': 'test name',
    'shopID': 'testID',
    'position': {}
  };

  setUp(() {
    shopModel = ShopModel(name: 'test name', shopID: 'testID', position: {});
  });

  test(
      'should return an equal shop object when constructed using fromJson factory',
      () {
    final jsonShop = ShopModel.fromJson(testMap);

    expect(jsonShop, shopModel);
  });
}
