import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_student_app/models/student.dart';


class StudentsDatabase {
  static final StudentsDatabase instance = StudentsDatabase._init();
  static Database? _database;

  StudentsDatabase._init();

  Future<Database> get database async {
    if (_database != null){
      return _database!;
    }
    _database = await _connectToDB('students.db');
    return _database!;
  }

  Future<Database> _connectToDB(String fileName) async {
    final dbURL = await getDatabasesPath();
    final completeURL = join(dbURL, fileName);

    return await openDatabase(completeURL, version: 1, onCreate: _createScheme);
  }

  Future _createScheme(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $studentsTable (
        ${StudentRecordFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${StudentRecordFields.name} TEXT NOT NULL,
        ${StudentRecordFields.age} INTEGER NOT NULL
      )
    ''');
  }

  Future<Student> insertOperation(Student student) async {
    final db = await instance.database;
    final id = await db.insert(studentsTable, student.convertToJson());
    return student.executeInsert(id: id);
  }

  Future<List<Student>> fetchAllStudents() async {
    final db = await instance.database;
    List<Map> result = await db.query(studentsTable);
    // result.forEach((row) => print(row));

    return result.map((json) => Student.fromJson(json)).toList();
  }

  Future<int> deleteStudent(int id) async {
    final db = await instance.database;

    return await db.delete(
      studentsTable,
      where: '${StudentRecordFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future terminateDb() async {
    final db = await instance.database;

    db.close();
  }
}