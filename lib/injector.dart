import 'package:kiwi/kiwi.dart';

import 'features/authentication/data/data_sources/authentication_service.dart';
import 'features/authentication/data/repositories/athentication_repository_impl.dart';
import 'features/authentication/domain/repositories/authentication_repository.dart';
import 'features/authentication/domain/usecases/get_current_user.dart';
import 'features/authentication/domain/usecases/verify_phone.dart';
import 'features/authentication/domain/usecases/verify_sms_code.dart';
import 'features/authentication/presentation/bloc/bloc.dart';
import 'features/find_shops/data/data_sources/get_shops_data_source.dart';
import 'features/find_shops/data/repositories/get_shops_repository_impl.dart';
import 'features/find_shops/domain/repositories/get_shops_repository.dart';
import 'features/find_shops/domain/usecases/get_nearby_shops.dart';
import 'features/find_shops/domain/usecases/get_shops_in_location.dart';
import 'features/find_shops/presentation/bloc/bloc.dart';
import 'features/reservation/data/data_sources/firestore_reservation_data_source.dart';
import 'features/reservation/data/repositories/reservation_repository_impl.dart';
import 'features/reservation/domain/repositories/reservation_repository.dart';
import 'features/reservation/domain/usecases/get_reservations.dart';
import 'features/reservation/domain/usecases/get_services.dart';
import 'features/reservation/domain/usecases/make_reservation.dart';
import 'features/reservation/presentation/bloc/reservation_bloc.dart';
import 'features/reservation/presentation/bloc/services_bloc.dart';
import 'features/reviews/data/data_sources/firestore_reviews_data_source.dart';
import 'features/reviews/data/data_sources/reviews_data_source.dart';
import 'features/reviews/data/repositories/reviews_repository_impl.dart';
import 'features/reviews/domain/repositories/reviews_repository.dart';
import 'features/reviews/domain/usecases/get_reviews.dart';
import 'features/reviews/domain/usecases/submit_review.dart';
import 'features/reviews/presentation/bloc/bloc.dart';

part 'injector.g.dart';

abstract class Injector {
  static Container container;

  static void setup() {
    container = Container();
    _$Injector()._configure();
  }

  static final resolve = container.resolve;

  void _configure() {
    _configureReservationModule();
    _configureGetShopsModule();
    _configureReviewsModule();
    _configureAuthenticationModule();
  }

  //! Reservation
  void _configureReservationModule() {
    _configureReservationInstances();
    _configureReservationFactories();
  }

  void _configureReservationInstances() {
    // container.registerInstance();
  }

  @Register.factory(ReservationBloc)
  @Register.factory(ServicesBloc)
  @Register.factory(GetServices)
  @Register.factory(GetReservations)
  @Register.factory(MakeReservation)
  @Register.factory(ReservationRepository, from: ReservationRepositoryImpl)
  @Register.factory(ReservationDataSource, from: FirestoreReservationDataSource)
  @Register.factory(FirestoreWrapper)
  void _configureReservationFactories();

  //! Authentication
  void _configureAuthenticationModule() {
    _configureAuthenticationInstances();
    _configureAuthenticationFactories();
  }

  void _configureAuthenticationInstances() {
    // container.registerInstance();
  }

  @Register.factory(VerifyPhoneBloc)
  @Register.factory(VerifyPhone)
  @Register.factory(VerifySmsCode)
  @Register.factory(GetCurrentUser)
  @Register.factory(AuthenticationRepository,
      from: AuthenticationRepositoryImpl)
  @Register.factory(AuthenticationService, from: FirebaseAuthenticationService)
  void _configureAuthenticationFactories();

  //! GetShops
  void _configureGetShopsModule() {
    _configureGetShopsInstances();
    _configureGetShopsFactories();
  }

  void _configureGetShopsInstances() {
    // container.registerInstance();
  }

  @Register.factory(GetShopsBloc)
  @Register.factory(GetShopsInLocation)
  @Register.factory(GetNearbyShops)
  @Register.factory(GetShopsRepository, from: GetShopsRepositoryImpl)
  @Register.factory(GetShopsDataSource, from: GetShopsDataSourceImpl)
  void _configureGetShopsFactories();

  //! Reviews
  void _configureReviewsModule() {
    _configureReviewsInstances();
    _configureReviewsFactories();
  }

  void _configureReviewsInstances() {
    // container.registerInstance();
  }

  @Register.factory(GetReviewsBloc)
  @Register.factory(SubmitReviewBloc)
  @Register.factory(SubmitReview)
  @Register.factory(GetReviews)
  @Register.factory(ReviewsRepository, from: ReviewsRepositoryImpl)
  @Register.factory(ReviewsDataSource, from: FirestoreReviewsDataSource)
  void _configureReviewsFactories();
}
