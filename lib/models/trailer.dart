class Trailer {
  int id;
  String plates;
  int capacity;
  String pickup;
  String dropoff;
  String status;
  String type;
  int owner;
  bool isAvailable;

  Trailer({
    required this.id,
    required this.plates,
    required this.capacity,
    required this.pickup,
    required this.dropoff,
    required this.status,
    required this.type,
    required this.owner,
    required this.isAvailable,
  });

  // Converts a Trailer instance into a map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'plates': plates,
        'capacity': capacity,
        'pickup': pickup,
        'dropoff': dropoff,
        'status': status,
        'type': type,
        'owner': owner,
        'isAvailable': isAvailable,
      };

  // Creates a Trailer instance from a map.
  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      id: json['id'],
      plates: json['plates'],
      capacity: json['capacity'],
      pickup: json['pickup'],
      dropoff: json['dropoff'],
      status: json['status'],
      type: json['type'],
      owner: json['owner'],
      isAvailable: json['isAvailable'],
    );
  }
}
