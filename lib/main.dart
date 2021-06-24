import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_list_page.dart';
import 'package:restaurant_app/presentation/themes/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'business_logic/bloc/restaurant_bloc.dart';
import 'data/model/restaurant_model.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => RestaurantBloc(context)..add(RestaurantLoadData()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(288, 624),
      builder: () => MaterialApp(
        initialRoute: RestaurantListPage.routeName,
        routes: {
          RestaurantListPage.routeName: (context) => RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant)
        },
        theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.teal,
            appBarTheme: AppBarTheme(textTheme: myTextTheme, elevation: 0),
            textTheme: myTextTheme),
      ),
    );
  }
}
