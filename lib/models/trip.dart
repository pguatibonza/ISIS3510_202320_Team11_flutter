class Trip{
  int id;
  int loadOwner;
  int? trailer;
  int load;
  int pickup;
  int dropoff;
  String status;
  
  Trip({
    required this.id,
    required this.loadOwner,
    this.trailer,
    required this.load,
    required this.pickup,
    required this.dropoff,
    required this.status
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json["id"],
      loadOwner: json["loadOwner"],
      trailer: json["trailer"],
      load: json["load"],
      pickup: json["pickup"],
      dropoff: json["dropoff"],
      status: json["status"],
    );
  }

}