import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final DateTime dateTime;
  final double rating;
  final String review;
  final String userID;

  Review({this.rating, this.review, this.dateTime, this.userID});

  @override
  List<Object> get props => [rating, review, dateTime, userID];
}
