class User {
  int? id;
  String? token;
  String? username;
  String? email, name, lastName, phone, userType;
  User(
      {this.id,
      this.token,
      this.username,
      this.email,
      this.name,
      this.lastName,
      this.phone,
      this.userType});
  factory User.fromJson(json) {
    return User(
      email: json["email"],
      id: json["id"],
      name: json["name"],
      lastName: json["lastName"],
      phone: json["phone"],
      username: json["username"],
      userType: json["userType"],
      token: "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'lastName': lastName,
      'phone': phone,
      'userType': userType,
      'id': id
    };
  }
}
