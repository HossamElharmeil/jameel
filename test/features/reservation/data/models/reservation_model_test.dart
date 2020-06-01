import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/features/reservation/data/models/reservation_model.dart';
import 'package:jameel/features/reservation/domain/entities/reservation.dart';

void main() {
  Timestamp dateTime;
  ReservationModel tReservation;
  String userID;
  String shopID;
  Map<String, dynamic> tMap;
  setUp((){
    userID = '13245';
    dateTime = Timestamp(5000, 0);
    shopID = 'Abo youssef';
    tMap = {'dateTime' : dateTime, 'userID': userID, 'shopID': shopID};
    tReservation = ReservationModel(dateTime: dateTime.toDate(), userID: userID, shopID: shopID);
  });
  
  test("Should return the same type when constructed from json", (){

    ReservationModel result;
    result = ReservationModel.fromJson(tMap);

    expect(result, isA<Reservation>());
    expect(result, equals(tReservation));
  });

  test('Should return the correct Json map when toJson is called', () {
    
    Map map = tReservation.toJson();

    expect(map, tMap);
  });
}
