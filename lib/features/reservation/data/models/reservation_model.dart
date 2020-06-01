import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jameel/features/reservation/domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  final DateTime dateTime;
  final String shopID;
  final String userID;

  ReservationModel({this.dateTime, this.shopID, this.userID}):super(dateTime: dateTime, shopID: shopID, userID: userID);

  factory ReservationModel.fromJson(Map<String, dynamic> map) {
    return ReservationModel(
      dateTime: map['dateTime'].toDate(),
      shopID: map['shopID'],
      userID: map['userID'],
    );
  }

  Map<String, dynamic> toJson(){
    Timestamp timestamp = Timestamp.fromDate(dateTime);
    Map<String, dynamic> result ={
      'dateTime' : timestamp,
      'shopID' : shopID,
      'userID' : userID,};
    return result;
  }

  @override
  List<Object> get props => [shopID, userID, dateTime];
}
