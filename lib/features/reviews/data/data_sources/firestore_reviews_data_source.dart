import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/review.dart';
import '../models/review_model.dart';
import 'reviews_data_source.dart';

class FirestoreReviewsDataSource extends ReviewsDataSource {
  @override
  Future<List<Review>> getReviews(String shopID) async {
    final querySnapshot = await Firestore.instance
        .collection('Shops')
        .document(shopID)
        .collection('reviews')
        .getDocuments();

    final reviewList = querySnapshot.documents.map(
      (document) {
        return ReviewModel.fromJson(document.data);
      },
    ).toList();

    return reviewList;
  }

  @override
  Future<bool> submitReview(ReviewModel review, String shopID) {
    Firestore.instance
        .collection('Shops')
        .document(shopID)
        .collection('reviews')
        .add(review.toJson());
    return Future.value(true);
  }
}
