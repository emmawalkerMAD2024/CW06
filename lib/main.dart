import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationScreen(),
    );
  }
}

// Authentication Screen
class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = true;

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaskListScreen()),
      );
    } catch (e) {
      print(e); // Handle login error
    }
  }

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      print("Passwords do not match!"); // Add proper error handling here
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaskListScreen()),
      );
    } catch (e) {
      print(e); // Handle registration error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Create Account')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (!_isLogin)
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
            ElevatedButton(
              onPressed: _isLogin ? _login : _register,
              child: Text(_isLogin ? 'Login' : 'Create Account'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? "Don't have an account? Sign up" : "Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// Task Model
class Task {
  String id;
  String name;
  bool isCompleted;
  Map<String, List<String>> schedule;

  Task({required this.id, required this.name, this.isCompleted = false, required this.schedule});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isCompleted': isCompleted,
      'schedule': schedule,
    };
  }

  static Task fromJson(Map<dynamic, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      isCompleted: json['isCompleted'],
      schedule: Map<String, List<String>>.from(json['schedule']),
    );
  }
}

// Main Task List Screen
class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _taskController = TextEditingController();
  final DatabaseReference _tasksRef = FirebaseDatabase.instance.ref().child('tasks');
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _tasksRef.onValue.listen((event) {
      final taskData = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _tasks = taskData.entries.map((e) => Task.fromJson(e.value)).toList();
      });
    });
  }

  void _addTask(String taskName) {
    final task = Task(
      id: _tasksRef.push().key!,
      name: taskName,
      schedule: {}, // Add nested schedule here as needed
    );
    _tasksRef.child(task.id).set(task.toJson());
  }

  void _deleteTask(String taskId) {
    _tasksRef.child(taskId).remove();
  }

  void _toggleCompletion(Task task) {
    _tasksRef.child(task.id).update({'isCompleted': !task.isCompleted});
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthenticationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Enter task name'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTask(_taskController.text);
              _taskController.clear();
            },
            child: Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(task.name),
                  subtitle: Text(task.schedule.toString()), // Display nested list
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTask(task.id),
                  ),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) => _toggleCompletion(task),
                  ),
                  onTap: () {
                    // Open detailed view for daily/hourly task schedule
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
