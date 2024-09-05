class FavoritesModel {
  bool status;
  List<FavoriteData> data = [];

  FavoritesModel.fromJson(Map<String, dynamic> json) : status = json['status'] {
    for (var e in json['data']['data']) {
      data.add(FavoriteData.fromJson(e['product']));
    }
  }
}

class FavoriteData {
  int id;
  num price;
  num oldPrice;
  int discount;
  String image;
  String name;
  String description;

  FavoriteData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        image = json['image'],
        name = json['name'],
        description = json['description'];
}
