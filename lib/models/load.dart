class Load{
  int id;
  String type;
  String trailerType;
  int weight;
  int? volume;

  Load({
  
    required this.id,
    required this.type,
    required this.trailerType,
    required this.weight,
    this.volume
  });

}