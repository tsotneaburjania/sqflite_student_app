import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_student_app/data/databases/students_database.dart';
import 'package:sqflite_student_app/models/student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<Student> students = [];

  @override
  void initState() {
    super.initState();
    reloadData();
  }

  Future reloadData() async {
    List<Student> studentsReceived = await StudentsDatabase.instance.fetchAllStudents();
    setState(() {
      students = studentsReceived;
    });
    print("CUMMIN");
  }

  Future deleteAction(int id) async {
    await StudentsDatabase.instance.deleteStudent(id);
    List<Student> studentsReceived = await StudentsDatabase.instance.fetchAllStudents();
    setState(() {
      students = studentsReceived;
    });
  }

  // @override
  // void dispose() {
  //   StudentsDatabase.instance.terminateDb();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3.0;
    double cardHeight = MediaQuery.of(context).size.height / 3.3;

    return Scaffold(
      appBar: AppBar(
        title: const Text("List of students"),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: students.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: cardWidth / cardHeight,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: (){
              deleteAction(students[index].id!);
              Navigator.pushNamed(context, '/');
            },
            child: Card(
              color: Colors.yellow,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(students[index].name, style: const TextStyle(color: Colors.black, fontSize: 25.0), textAlign: TextAlign.center,),
                      ),
                      subtitle: Text(students[index].age.toString(), style: const TextStyle(color: Colors.black), textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: (){
          // log('data: ${futureTodo.id}');
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
