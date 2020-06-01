import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/review.dart';

class ReviewModel extends Review {
  final DateTime dateTime;
  final double rating;
  final String review;
  final String userID;

  ReviewModel({this.dateTime, this.rating, this.review, this.userID});

  factory ReviewModel.fromJson(Map map) {
    return ReviewModel(
      dateTime: map['dateTime'].toDate(),
      rating: (map['rating'] as num).toDouble(),
      review: map['review'],
      userID: map['userID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': Timestamp.fromDate(dateTime),
      'rating': rating,
      'review': review,
      'userID': userID,
    };
  }
}
