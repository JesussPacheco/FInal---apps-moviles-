import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_mycinees/models/restaurant.dart';
import 'package:app_mycinees/utils/db_helper.dart';

class RestaurantDetail extends StatefulWidget {
  final Restaurant restaurant;
  RestaurantDetail(this.restaurant);

  @override
  _RestaurantDetailState createState() => _RestaurantDetailState(restaurant);
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final Restaurant restaurant;
  DbHelper? dbHelper;
  String? path;

  _RestaurantDetailState(this.restaurant);

  @override
  void initState(){
    dbHelper = DbHelper();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.title.toString()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: Hero(
                  tag: 'poster_' + restaurant.id.toString(),
                  child: Image.network(restaurant.posterPath.toString(),
                    height: height / 1.5,)
              ),
            )

          ],),
        ),
      ),
    );
  }
}
