import 'package:page_view/models/home_data.dart';

class SearchData {
  List<Product> products = [];

  SearchData({required this.products});

  SearchData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((e) {
      products.add(Product.fromJson(e));
    });
  }
}
