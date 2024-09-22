import 'package:flutter/material.dart';
import 'package:newprojecttodo/profilepage.dart';
import 'package:newprojecttodo/splash.dart';
import 'package:newprojecttodo/taskpage.dart';
import 'package:newprojecttodo/taskprovider.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final TaskProvider _taskProvider = TaskProvider();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _taskProvider.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask() async {
    final title = await _showTaskDialog(currentTitle: "0");
    if (title != null) {
      await _taskProvider.addTask(Task(title: title));
      _loadTasks();
    }
  }

  void _editTask(int index) async {
    final title = await _showTaskDialog(currentTitle: _tasks[index].title);
    if (title != null) {
      await _taskProvider.editTask(
          index, Task(title: title, isCompleted: _tasks[index].isCompleted));
      _loadTasks();
    }
  }

  Future<String?> _showTaskDialog({required String currentTitle}) async {
    String? title;
    return showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(currentTitle == "0" ? 'New Task' : 'Edit Task'),
            content: TextField(
              onChanged: (value) {
                title = value;
              },
              decoration: const InputDecoration(hintText: 'Task Title'),
              controller: currentTitle != null
                  ? TextEditingController(text: currentTitle)
                  : null,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(title);
                },
                child: const Text('Add'),
              ),
            ],
          );
        });
  }

  void _deleteTask(int index) async {
    await _taskProvider.deleteTask(index);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _addTask();
          }),
      backgroundColor: Color.fromARGB(255, 20, 91, 72),
      appBar: AppBar(
        title: const Text(
          "To-do List",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color.fromARGB(255, 212, 215, 230)),
        ),
        backgroundColor: Color.fromARGB(255, 107, 157, 108),
        elevation: 12,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      drawer: Drawer(
        shadowColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 160, 195, 148),
        child: ListView(
          children: [
            ListTile(
              title: const Text("Account"),
              textColor: Color.fromARGB(255, 13, 13, 13),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ));
              },
            ),
            ListTile(
              title: const Text("Signout"),
              textColor: Color.fromARGB(255, 13, 13, 13),
              onTap: () {
                storingDatatoPreff(false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ));
              },
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: const Color.fromARGB(255, 203, 202, 198),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(_tasks[index].title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTask(index),
                  ),
                  onTap: () => _editTask(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
