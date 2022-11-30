import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_mycinees/utils/db_helper.dart';
import 'package:app_mycinees/utils/http_helper.dart';
import 'package:app_mycinees/models/restaurant.dart';
import 'package:app_mycinees/UI/restaurant_detail.dart';

import 'restaurant_detail.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Restaurant> restaurants=[];
  int? restaurantsCount;
  int page = 1;
  bool loading = true;
  HttpHelper? helper;
  ScrollController? _scrollController;

  Future initialize() async{
    //ojo
    //restaurants = List<Restaurant>();
    loadMore();
    initScrollController();
  }

  @override
  void initState(){
    super.initState();
    helper = HttpHelper();
    initialize();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: restaurants!.length,
        itemBuilder: (BuildContext context, int index){
          return RestaurantRow(restaurants![index]);
        },
      ),
    );
  }

  void loadMore() {
    helper!.getUpcoming(page.toString()).then((value) {
      restaurants += value;
      setState(() {
        restaurantsCount = restaurants.length;
        restaurants = restaurants;
        page++;
      });

      if(restaurants.length % 20 > 0){
        loading = false;
      }
    });
  }

  void initScrollController() {
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      if ((_scrollController!.position.pixels ==
          _scrollController!.position.maxScrollExtent) &&
          loading){
        loadMore();
      }
    });
  }
}

class RestaurantRow extends StatefulWidget {
  final Restaurant restaurant;
  RestaurantRow(this.restaurant);

  @override
  _RestaurantRowState createState() => _RestaurantRowState(restaurant);
}

class _RestaurantRowState extends State<RestaurantRow> {
  Restaurant restaurant;
  _RestaurantRowState(this.restaurant);

  late bool favorite;
  late DbHelper dbHelper;
  //String path;

  @override
  void initState(){
    favorite = false;
    dbHelper = DbHelper();
    isFavorite(restaurant);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: Hero(
          tag: 'poster_'+widget.restaurant.id.toString(),
          child: Image.network('https://image.tmdb.org/t/p/w500'+restaurant.posterPath.toString()),
        ),
        title: Text(widget.restaurant.title.toString()),
        subtitle: Text(widget.restaurant.overview.toString()),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => RestaurantDetail(widget.restaurant)
            ),
          ).then((value) {
            isFavorite(restaurant);
          });
        },
        trailing: IconButton(
          icon: Icon(Icons.favorite),
          color: favorite ? Colors.red : Colors.grey,
          onPressed: (){
            favorite ? dbHelper.deleteRestaurant(restaurant) : dbHelper.insertRestaurant(restaurant);
            setState(() {
              favorite = !favorite;
              restaurant.isFavorite = favorite;
            });
          },
        ),
      ),
    );
  }

  Future isFavorite(Restaurant restaurant) async {
    await dbHelper.openDb();
    favorite = await dbHelper.isFavorite(restaurant);
    setState(() {
      restaurant.isFavorite = favorite;
    });
  }
}

