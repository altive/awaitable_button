// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:awaitable_button/awaitable_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AwaitableButton Demo',
      theme: ThemeData(
        useMaterial3: true,
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
  const MyHomePage({super.key});

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
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            'AwaitableElevatedButton',
            style: Theme.of(context).textTheme.headline6,
          ),
          const Text(
            'Screen transition after processing is completed',
          ),
          AwaitableElevatedButton<void>(
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
          const Text(
            'Can change the text being processed',
          ),
          AwaitableElevatedButton<void>(
            onPressed: () async {
              await Future<void>.delayed(const Duration(seconds: 2));
            },
            executingChild: const Text('Executing...'),
            child: const Text('Executing Text'),
          ),
          const Text(
            'Pass the result of processing to [whenComplete]',
          ),
          AwaitableElevatedButton<String>(
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
          const Text(
            'Handling Exceptions with [onError]',
          ),
          AwaitableElevatedButton<void>(
            onPressed: () async {
              await Future<void>.delayed(const Duration(seconds: 2));
              if (Random().nextBool()) {
                throw Exception();
              }
            },
            onError: (exception, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$exception, $stackTrace')),
              );
            },
            whenComplete: (_) {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Succeeded'),
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
          const Divider(),
          Text(
            'AwaitableTextButton',
            style: Theme.of(context).textTheme.headline6,
          ),
          const Text(
            'It is the same as [AwaitableElevatedButton] except for the style.',
          ),
          AwaitableTextButton<void>(
            onPressed: () async {
              await Future<void>.delayed(const Duration(seconds: 2));
            },
            executingChild: const Text('Executing...'),
            child: const Text('Executing Text'),
          ),
          const Divider(),
          Text(
            'AwaitableIconButton',
            style: Theme.of(context).textTheme.headline6,
          ),
          const Text(
            'Success or Failure handling',
          ),
          AwaitableIconButton<void>(
            onPressed: () async {
              await Future<void>.delayed(const Duration(seconds: 2));
              if (Random().nextBool()) {
                throw Exception();
              }
            },
            whenComplete: (_) {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Succeeded'),
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
            onError: (exception, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$exception, $stackTrace')),
              );
            },
            icon: const Icon(Icons.timer),
          ),
          const Text(
            'Can change the icon being processed',
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
