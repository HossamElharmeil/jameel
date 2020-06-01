import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String shopID;
  final String userID;
  final DateTime dateTime;

  Reservation({this.shopID, this.userID, this.dateTime});

  @override
  String toString() {
    return "Reservation => userID: $userID, salon: $shopID, date: $dateTime";
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'shopID': shopID,
      'dateTime': dateTime,
    };
  }

  @override
  List<Object> get props => [userID, shopID, dateTime];
}
