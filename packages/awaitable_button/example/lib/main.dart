import 'dart:math';

import 'package:awaitable_button/awaitable_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AwaitableButton Demo',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('awaitable_button'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        children: <Widget>[
          AwaitableButton<void>(
            onPressed: () async {
              await Future<void>.delayed(const Duration(seconds: 2));
            },
            whenComplete: (_) {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(),
                      body: const Center(child: Text('Next page')),
                    );
                  },
                ),
              );
            },
            child: const Text('After processing, go to the next page'),
          ),
          AwaitableButton<void>(
            onPressed: () async {
              await Future<void>.delayed(const Duration(seconds: 2));
            },
            executingChild: const Text('Executing...'),
            child: const Text('Executing Text'),
          ),
          AwaitableButton<String>(
            onPressed: () async {
              try {
                await Future<void>.delayed(const Duration(seconds: 2));
                if (Random().nextBool()) {
                  return 'Succeeded';
                } else {
                  throw Exception();
                }
              } on Exception {
                return 'Failed';
              }
            },
            whenComplete: (value) {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(value),
                    actions: [
                      TextButton(
                        onPressed: Navigator.of(context).pop,
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Success or Failure'),
          ),
          AwaitableIconButton<void>(
            onPressed: () async {
              await Future<void>.delayed(const Duration(seconds: 1));
            },
            icon: const Icon(Icons.timer),
          ),
          AwaitableIconButton<void>(
            onPressed: () async {
              await Future<void>.delayed(const Duration(seconds: 1));
            },
            executingIcon: const Icon(Icons.timer_sharp),
            icon: const Icon(Icons.timer),
          ),
        ].fold([], (widgets, next) {
          return widgets
            ..addAll([
              const SizedBox(height: 16),
              next,
            ]);
        }),
      ),
    );
  }
}
