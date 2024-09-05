class HomeDataModel {
  bool status;
  Data data;

  HomeDataModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = Data.fromJson(json['data']);
}

class Data {
  List<Banner> banners = [];
  List<Product> products = [];

  Data.fromJson(Map<String, dynamic> json) {
    for (var e in json['banners']) {
      banners.add(Banner.fromJson(e));
    }

    for (var e in json['products']) {
      products.add(Product.fromJson(e));
    }
  }
}

class Banner {
  int id;
  String image;

  Banner.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'];
}

class Product {
  int id;
  num price;
  num oldPrice;
  num discount;
  String image;
  String name;
  String description;
  bool inFavorites;
  bool inCart;
  List<dynamic> images;
  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'] ?? 0,
        discount = json['discount'] ?? 0,
        image = json['image'],
        name = json['name'],
        description = json['description'],
        inFavorites = json['in_favorites'],
        inCart = json['in_cart'],
        images = json['images'];
}
