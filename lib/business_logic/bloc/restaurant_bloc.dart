import 'dart:async';

import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final BuildContext context;

  RestaurantBloc(this.context) : super(RestaurantInitial());

  @override
  Stream<RestaurantState> mapEventToState(
    RestaurantEvent event,
  ) async* {
    if (event is RestaurantLoadData) {
      yield RestaurantDataLoading();

      try {
        final String loadedData = await DefaultAssetBundle.of(context)
            .loadString('lib/data/providers/local_restaurant.json');

        final Map<String, dynamic>parsedJson = json.decode(loadedData);

        yield RestaurantDataLoaded(
            RestaurantModel.fromJson(parsedJson));
      } catch (e) {
        yield RestaurantErrorLoaded(e);
      }
    }
  }
}
