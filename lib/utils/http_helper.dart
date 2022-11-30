import 'package:app_mycinees/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class HttpHelper {
  //https://api.themoviedb.org/3/movie/upcoming?api_key=3cae426b920b29ed2fb1c0749f258325
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlKey = 'api_key=3cae426b920b29ed2fb1c0749f258325';
  final String urlPage = '&page=';

  Future<List<Restaurant>> getUpcoming(String page) async{
    final String upcoming = urlBase + urlUpcoming + urlKey + urlPage + page;
    print(upcoming);
    http.Response result = await http.get(Uri.parse(upcoming));

    if(result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];

      List<Restaurant> movies = moviesMap.map<Restaurant>((i) =>
          Restaurant.fromJson(i)).toList();

      return movies;
    }else{
      print(result.body);
      return null!;
    }
  }
}