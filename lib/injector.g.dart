// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void _configureReservationFactories() {
    final Container container = Container();
    container.registerFactory((c) => ReservationBloc(
        getReservations: c<GetReservations>(),
        makeReservation: c<MakeReservation>()));
    container
        .registerFactory((c) => ServicesBloc(getServices: c<GetServices>()));
    container.registerFactory(
        (c) => GetServices(reservationRepository: c<ReservationRepository>()));
    container.registerFactory((c) =>
        GetReservations(reservationRepository: c<ReservationRepository>()));
    container.registerFactory((c) =>
        MakeReservation(reservationRepository: c<ReservationRepository>()));
    container.registerFactory<ReservationRepository, ReservationRepositoryImpl>(
        (c) =>
            ReservationRepositoryImpl(dataSource: c<ReservationDataSource>()));
    container.registerFactory<ReservationDataSource,
            FirestoreReservationDataSource>(
        (c) => FirestoreReservationDataSource(wrapper: c<FirestoreWrapper>()));
    container.registerFactory((c) => FirestoreWrapper());
  }

  void _configureAuthenticationFactories() {
    final Container container = Container();
    container.registerFactory((c) => VerifyPhoneBloc(
        verifyPhone: c<VerifyPhone>(),
        verifySmsCode: c<VerifySmsCode>(),
        getCurrentUser: c<GetCurrentUser>()));
    container.registerFactory((c) =>
        VerifyPhone(authenticationRepository: c<AuthenticationRepository>()));
    container.registerFactory((c) =>
        VerifySmsCode(authenticationRepository: c<AuthenticationRepository>()));
    container.registerFactory((c) => GetCurrentUser(
        authenticationRepository: c<AuthenticationRepository>()));
    container.registerFactory<AuthenticationRepository,
            AuthenticationRepositoryImpl>(
        (c) => AuthenticationRepositoryImpl(
            authenticationService: c<AuthenticationService>()));
    container.registerFactory<AuthenticationService,
        FirebaseAuthenticationService>((c) => FirebaseAuthenticationService());
  }

  void _configureGetShopsFactories() {
    final Container container = Container();
    container.registerFactory((c) => GetShopsBloc(
        getNearbyShops: c<GetNearbyShops>(),
        getShopsInLocation: c<GetShopsInLocation>()));
    container.registerFactory(
        (c) => GetShopsInLocation(repository: c<GetShopsRepository>()));
    container.registerFactory(
        (c) => GetNearbyShops(repository: c<GetShopsRepository>()));
    container.registerFactory<GetShopsRepository, GetShopsRepositoryImpl>(
        (c) => GetShopsRepositoryImpl(dataSource: c<GetShopsDataSource>()));
    container.registerFactory<GetShopsDataSource, GetShopsDataSourceImpl>(
        (c) => GetShopsDataSourceImpl());
  }

  void _configureReviewsFactories() {
    final Container container = Container();
    container
        .registerFactory((c) => GetReviewsBloc(getReviews: c<GetReviews>()));
    container.registerFactory(
        (c) => SubmitReviewBloc(submitReview: c<SubmitReview>()));
    container.registerFactory(
        (c) => SubmitReview(repository: c<ReviewsRepository>()));
    container.registerFactory(
        (c) => GetReviews(reviewsRepository: c<ReviewsRepository>()));
    container.registerFactory<ReviewsRepository, ReviewsRepositoryImpl>(
        (c) => ReviewsRepositoryImpl(dataSource: c<ReviewsDataSource>()));
    container.registerFactory<ReviewsDataSource, FirestoreReviewsDataSource>(
        (c) => FirestoreReviewsDataSource());
  }
}
