import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/features/reviews/data/models/review_model.dart';

void main() {
  Timestamp timestamp = Timestamp(5000, 0);
  Map tMap = {
    'dateTime': timestamp,
    'rating': 4.2,
    'review': 'test review string',
    'userID': 'test userID'
  };
  ReviewModel reviewModel;

  setUp(() {
    reviewModel = ReviewModel(
        dateTime: timestamp.toDate(),
        rating: 4.2,
        review: 'test review string',
        userID: 'test userID');
  });

  test('should return an equal to reviewModel when constructed from json', () {
    final result = ReviewModel.fromJson(tMap);

    expect(result, reviewModel);
  });

  test('should return the same map when toJson is called', () {
    final result = reviewModel.toJson();

    expect(result, tMap);
  });
}
