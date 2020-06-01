import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../domain/usecases/get_services.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final GetServices getServices;

  ServicesBloc({@required this.getServices});
  @override
  ServicesState get initialState => ServicesInitial();

  @override
  Stream<ServicesState> mapEventToState(
    ServicesEvent event,
  ) async* {
    if (event is ServicesRequested) {
      yield ServicesLoadInProgress();
      final services = await getServices(event.salonID);
      yield* services.fold(
        (failure) async* {
          yield ServicesLoadFailure(failure);
        },
        (list) async* {
          yield ServicesLoadSuccess(list);
        },
      );
    }
  }
}
