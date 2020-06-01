import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/reservation.dart';
import '../../domain/entities/service.dart';
import '../models/reservation_model.dart';
import '../models/service_model.dart';

abstract class ReservationDataSource {
  Future<List<Reservation>> getReservations(String userID);
  Future<bool> makeReservation(Reservation reservation);
  Future<List<Service>> getServices(String salonID);
}

class FirestoreReservationDataSource implements ReservationDataSource {
  final FirestoreWrapper wrapper;

  FirestoreReservationDataSource({@required this.wrapper});

  @override
  Future<List<Reservation>> getReservations(String userID) async {
    try {
      return await wrapper.getReservations(userID);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> makeReservation(Reservation reservation) async {
    try {
      await wrapper.makeReservation(reservation);
      return Future.value(true);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<Service>> getServices(String salonID) async {
    try {
      return await wrapper.getServices(salonID);
    } catch (e) {
      rethrow;
    }
  }
}

class FirestoreWrapper {
  Future<List<Reservation>> getReservations(String userID) async {
    try {
      final querySnapshot = await Firestore.instance
          .collection('Reservations')
          .where('userID', isEqualTo: userID)
          .getDocuments();

      final mapList =
          querySnapshot.documents.map((snapshot) => snapshot.data).toList();

      return mapList.map((map) => ReservationModel.fromJson(map)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> makeReservation(Reservation reservation) {
    try {
      Firestore.instance.collection('Reservations').add(reservation.toJson());
      return null;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Service>> getServices(String salonID) async {
    try {
      final querySnapshot = await Firestore.instance
          .collection("Shops")
          .document(salonID)
          .collection("services")
          .getDocuments();

      final servicesList = querySnapshot.documents.map((documentSnapshot) {
        return ServiceModel.fromJson(documentSnapshot.data);
      }).toList();

      return servicesList;
    } catch (_) {
      rethrow;
    }
  }
}
