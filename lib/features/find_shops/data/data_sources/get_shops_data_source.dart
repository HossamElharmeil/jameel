import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_firestore/geo_firestore.dart';
import 'package:location/location.dart';

import '../../domain/entities/shop.dart';
import '../models/shop_model.dart';

abstract class GetShopsDataSource {
  Future<List<Shop>> getNearbyShops(double radius);
  Future<List<Shop>> getShopsInLocation(
      double latitude, double longitude, double radius);
}

class GetShopsDataSourceImpl implements GetShopsDataSource {
  @override
  Future<List<Shop>> getNearbyShops(double radius) async {
    final collectionReference = Firestore.instance.collection('Shops');

    GeoFirestore geoFirestore = new GeoFirestore(collectionReference);
    Location locationService = Location();

    final location = await locationService.getLocation();
    final center = GeoPoint(location.latitude, location.longitude);

    final documentList = await geoFirestore.getAtLocation(center, radius);

    final shopList = documentList.map((documentSnapshot) {
      return ShopModel.fromJson(documentSnapshot.data);
    }).toList();

    return shopList;
  }

  @override
  Future<List<Shop>> getShopsInLocation(
      double latitude, double longitude, double radius) async {
    final collectionReference = Firestore.instance.collection('Shops');
    GeoFirestore geoFirestore = new GeoFirestore(collectionReference);

    final center = GeoPoint(latitude, longitude);

    final documentList = await geoFirestore.getAtLocation(center, radius);

    final shopList = documentList.map((documentSnapshot) {
      return ShopModel.fromJson(documentSnapshot.data);
    }).toList();

    return shopList;
  }
}
