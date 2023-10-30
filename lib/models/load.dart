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
class Choice {
  final String value;
  final String label;

  Choice({required this.value, required this.label});
}
List<Choice> choices = [
    Choice(value: 'AN', label: 'Any'),
    Choice(value: 'DV', label: 'Dry van'),
    Choice(value: 'RF', label: 'Reefer'),
    Choice(value: 'LB', label: 'lowboy'),
    Choice(value: 'SD', label: 'Stepdeck'),
    Choice(value: 'OT', label: 'Other'),
];