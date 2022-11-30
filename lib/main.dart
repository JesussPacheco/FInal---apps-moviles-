import 'package:flutter/material.dart';
import 'package:app_mycinees/UI/restaurant_list.dart';

import 'UI/movie_list.dart';

void main() {
  runApp(MyRestaurants());
}

class MyRestaurants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My restaurants',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RestaurantList(),
    );
  }
}