class AbsenceType {
  int id;
  String name;

  AbsenceType();

  factory AbsenceType.fromJson(Map<String, dynamic> input) {
    AbsenceType a = new AbsenceType()
      ..id = input["id"]
      ..name = input["name"];

    return a;
  }
}