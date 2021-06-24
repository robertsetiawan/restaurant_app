import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/presentation/themes/style.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: restaurant.id,
                  child: Image.network(
                    restaurant.pictureId,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${restaurant.name}',
                          style: myTextTheme.headline4,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                            ),
                            Text(
                              ' ${restaurant.rating.toString()}',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.place),
                            Text(' ${restaurant.city}'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Column(
                            children: [
                              Text(
                                '${restaurant.description}',
                                style: myTextTheme.bodyText1,
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                        ),
                        _buildListMenu(
                            title: 'List foods',
                            listMenus: restaurant.menus.foods),
                        _buildListMenu(
                            title: 'List Drinks',
                            listMenus: restaurant.menus.drinks)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListMenu(
      {required String title, required List<Makanan> listMenus}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Row(children: [
            Text(title),
            SizedBox(width: 10.w),
            Expanded(child: Divider())
          ]),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Wrap(
              runSpacing: 10.0.w,
              spacing: 10.0.h,
              direction: Axis.horizontal,
              children: listMenus
                  .map(
                    (food) => Container(
                      width: 100.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.bottomLeft,
                      child: Text('${food.name}'),
                    ),
                  )
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}
