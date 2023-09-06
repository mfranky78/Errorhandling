import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() {
    return 'CustomException: $message';
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExceptionDemo(),
    );
  }
}

class ExceptionDemo extends StatelessWidget {
  final List<Exception> exceptions = [
    CustomException("Benutzerdefinierte Exception"),
    const FormatException("Format Exception"),
    Exception("Allgemeine Exception"), 
  ];

  void throwRandomException() {
    final random = Random();
    final index = random.nextInt(exceptions.length);
    throw exceptions[index];
  }

void showErrorScreen(BuildContext context, dynamic exception) {
  String errorMessage;
  if (exception is CustomException) {
    errorMessage = "Benutzerdefinierte Exception behandelt: ${exception.message}";
  } else {
    errorMessage = "Eine Ausnahme wurde behandelt: $exception";
  }

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ErrorScreen(errorMessage),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exception'),
      ),
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  try {
                    throwRandomException();
                  } catch (e) {
                    // Zeige Fehlerbildschirm basierend auf der Exception an
                    showErrorScreen(context, e);
                  }
                  
                },
                child: const Text('Exception Anzeigen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fehlerbildschirm'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Ein Fehler ist aufgetreten:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                errorMessage,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
