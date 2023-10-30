class Trailer{
  String plates;
  int capacity;
  int? volume;
  String pickup;
  String dropoff;
  String status;
  String type;
  int? driver;
  int owner;
 Trailer({
  required this.plates,
  required this.capacity,
  this.volume,
  required this.pickup,
  required this.dropoff,
  required this.status,
  required this.type,
  this.driver,
  required this.owner
 
 }); 
}
