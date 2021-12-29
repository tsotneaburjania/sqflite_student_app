const String studentsTable = 'students';

class StudentRecordFields {
  static const String id = "_id";
  static const String name = "name";
  static const String age = "age";

  static const List<String> colNames = [id, name, age];
}

class Student {
  final int? id;
  final String name;
  final int age;

  Student({
    this.id,
    required this.name,
    required this.age,
  });

  Student executeInsert({int? id, String? name, int? age}) => Student(id: id ?? this.id, name: name ?? this.name, age: age ?? this.age);

  static Student fromJson(Map<dynamic, dynamic> jsonData) => Student(
    id: jsonData[StudentRecordFields.id] as int,
    name: jsonData[StudentRecordFields.name] as String,
    age: jsonData[StudentRecordFields.age] as int,
  );

  Map<String, Object?> convertToJson(){
    var  map = {
      StudentRecordFields.id: id,
      StudentRecordFields.name: name,
      StudentRecordFields.age: age,
    };

    return map;
  }
}