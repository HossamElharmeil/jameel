import 'package:equatable/equatable.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();
}

class ServicesRequested extends ServicesEvent {
  final String salonID;

  ServicesRequested(this.salonID);
  @override
  List<Object> get props => [salonID];
}
