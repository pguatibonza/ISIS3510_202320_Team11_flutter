class AccessPoint{
 int id;
 String country;
 String city;
 String address;
 DateTime before;
 DateTime after;
 AccessPoint({
    required this.id,
    required this.country,
    required this.city,
    required this.address,
    required this.before,
    required this.after
  });
  factory AccessPoint.fromJson(Map<String, dynamic> json) {
    return AccessPoint(
      id: json["id"],
      country: json["country"],
      city: json["city"],
      address: json["address"],
      before: DateTime.parse(json["before"]),
      after: DateTime.parse(json["after"]),
    );
    }
}