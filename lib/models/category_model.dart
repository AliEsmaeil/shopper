class CategoryModel {
  bool status;
  Data data;

  CategoryModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = Data.fromJson(json['data']);
}

class Data {
  List<Category> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    for (var e in json['data']) {
      data.add(Category.fromJson(e));
    }
  }
}

class Category {
  int id;
  String name;
  String image;

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'];
}
