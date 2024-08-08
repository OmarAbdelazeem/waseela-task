import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<String> _tasks = [];
  final List<bool> _completed = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    final task = _taskController.text;
    if (task.isNotEmpty && !_tasks.contains(task)) {
      setState(() {
        _tasks.add(task);
        _completed.add(false);
        _taskController.clear();
      });
    }
  }

  void _removeCompletedTasks() {
    setState(() {
      for (int i = _tasks.length - 1; i >= 0; i--) {
        if (_completed[i]) {
          _tasks.removeAt(i);
          _completed.removeAt(i);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _removeCompletedTasks,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Add a new task',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  key: UniqueKey(),
                  leading: Checkbox(
                    value: _completed[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _completed[index] = value!;
                      });
                    },
                  ),
                  title: Text(
                    _tasks[index],
                    style: TextStyle(
                      decoration: _completed[index]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
