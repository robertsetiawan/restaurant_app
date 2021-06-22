part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantDataLoaded extends RestaurantState {
  final RestaurantModel restaurantModel;

  RestaurantDataLoaded(this.restaurantModel);

  @override
  List<Object> get props => [restaurantModel];
}

class RestaurantDataLoading extends RestaurantState {}

class RestaurantErrorLoaded extends RestaurantState {
  final dynamic error;

  RestaurantErrorLoaded(this.error);

  @override
  List<Object> get props => [error];
}
