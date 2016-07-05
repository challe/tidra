class Auth {
  bool error;
  String username;
  String password;
  String token;

  Auth();

  Map toJson() {
    Map map = new Map();
    map["username"] = this.username;
    map["password"] = this.password;

    return map;
  }

  factory Auth.fromJson(Map<String, dynamic> input) {
    Auth a = new Auth()
      ..error = input["error"]
      ..token = input["token"]
      ..username = input["username"]
      ..password = input["password"];

    return a;
  }
}