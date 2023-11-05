import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_notes/home_screen.dart';
import 'package:todo_notes/providers/note_provider.dart';
import 'package:todo_notes/providers/todo_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => NotesProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.orange),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(child: HomeScreen()),
      ),
    );
  }
}
