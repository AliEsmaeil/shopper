class RegisterUser {
  String name;
  String phone;
  String email;
  String password;

  RegisterUser(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password});

  RegisterUser.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      };
}
