class Persons {
  final int id;
  final String name;
  final int age;

  Persons({required this.id, required this.name, required this.age});

  factory Persons.fromJson(Map<String, dynamic> json) {
    return Persons(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'],
      age: json['age'] is int ? json['age'] : int.parse(json['age'].toString()),
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'age': age};
  }
}
