import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/business_logic/bloc/restaurant_bloc.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/presentation/themes/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';
  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  List<Restaurant> sourceList = [];

  List<Restaurant> searchResult = [];

  final TextEditingController textEditingController =
      new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurant',
              style: myTextTheme.headline4,
            ),
            TextField(
              onChanged: handleSearch,
              controller: textEditingController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15.w, 8.h, 5.w, 8.h),
                  border: OutlineInputBorder(),
                  hintText: 'Enter a restaurant name'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                'Recommendation restaurant for you',
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(child: BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                if (state is RestaurantDataLoaded) {
                  sourceList = state.restaurantModel.listRestaurant;
                  return (searchResult.isNotEmpty &&
                          textEditingController.text.isNotEmpty)
                      ? _buildRestaurantList(searchResult)
                      : _buildRestaurantList(sourceList);
                } else if (state is RestaurantDataLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is RestaurantErrorLoaded) {
                  return Column(children: [
                    Text(
                      state.error.toString(),
                      textAlign: TextAlign.center,
                    )
                  ]);
                } else {
                  return Container();
                }
              },
            )),
          ],
        ),
      ),
    ));
  }

  void handleSearch(String searchText) {
    if (searchResult.isNotEmpty) {
      setState(() {
        searchResult.clear();
      });
    }

    for (int i = 0; i < sourceList.length; i++) {
      if (sourceList[i].name.toLowerCase().contains(searchText.toLowerCase())) {
        setState(() {
          searchResult.add(sourceList[i]);
        });
      }
    }
  }

  Widget _buildRestaurantList(List<Restaurant> listRestaurant) {
    return ListView.builder(
        itemCount: listRestaurant.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                    arguments: listRestaurant[index]);
              },
              leading: Hero(
                tag: listRestaurant[index].id,
                child: Image.network(
                  listRestaurant[index].pictureId.toString(),
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listRestaurant[index].name.toString()),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star),
                      Text(
                        ' ${listRestaurant[index].rating.toString()}',
                        style: myTextTheme.subtitle2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.place),
                      Text(' ${listRestaurant[index].city}',
                          style: myTextTheme.subtitle2),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
