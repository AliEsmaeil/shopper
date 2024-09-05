class LoginResponse {
  bool status;
  String message;
  UserData? data;
  LoginResponse(
      {required this.status, required this.message, required this.data});

  LoginResponse.fromJson({required Map<String, dynamic> response})
      : status = response['status'],
        message = response['message'],
        data = response['data'] == null
            ? null
            : UserData.fromJson(json: response['data']);
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  UserData.fromJson({required Map<String, dynamic> json})
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        image = json['image'],
        points = json['points'],
        credit = json['credit'],
        token = json['token'];
}
