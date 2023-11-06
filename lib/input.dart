import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserInputScreen(),
    );
  }
}

class UserInputScreen extends StatefulWidget {
  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final TextEditingController _userInputController = TextEditingController();
  String savedUserInput = '';

  @override
  void initState() {
    super.initState();
    _loadUserInput();
  }

  Future<void> _loadUserInput() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedUserInput = prefs.getString('user_input') ?? '';
    });
  }

  Future<void> _saveUserInput(String userInput) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_input', userInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Input Storage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userInputController,
              decoration: InputDecoration(labelText: 'Enter User Input'),
            ),
            ElevatedButton(
              onPressed: () {
                final userInput = _userInputController.text;
                _saveUserInput(userInput);
                setState(() {
                  savedUserInput = userInput;
                });
              },
              child: Text('Save Input'),
            ),
            Text('Saved User Input: $savedUserInput'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userInputController.dispose();
    super.dispose();
  }
}
