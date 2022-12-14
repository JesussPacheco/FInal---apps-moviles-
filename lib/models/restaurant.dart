class Restaurant {
  double? popularity;
  String? posterPath;
  int? id;
  String? title;
  String? overview;
  String? releaseDate;
  bool? isFavorite;

  Restaurant(
      {this.popularity,
        this.posterPath,
        this.id,
        this.title,
        this.overview,
        this.releaseDate,
        this.isFavorite});

  Restaurant.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster'];
    id = json['id'];
    title = json['title'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['title'] = this.title;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['isFavorite'] = this.isFavorite;
    return data;
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'title': title,
    };
  }
}