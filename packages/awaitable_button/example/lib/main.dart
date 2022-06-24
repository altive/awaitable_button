// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:awaitable_button/awaitable_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool useMaterial3 = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awaitable Button',
      theme: ThemeData(
        useMaterial3: useMaterial3,
        colorSchemeSeed: useMaterial3 ? Colors.green : null,
        primarySwatch: useMaterial3 ? null : Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
      ),
      home: MyHomePage(
        useMaterial3: useMaterial3,
        onFabPressed: () => setState(() {
          useMaterial3 = !useMaterial3;
        }),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.useMaterial3,
    required this.onFabPressed,
  });

  final bool useMaterial3;

  final VoidCallback onFabPressed;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awaitable Button'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: widget.onFabPressed,
        label: Text(widget.useMaterial3 ? 'Use Material 2' : 'Use Material 3'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Wrap(
            children: [
              TextButton(
                onPressed: () {
                  launchUrl(
                      Uri.parse('https://pub.dev/packages/awaitable_button'));
                },
                child: const Text('pub.dev'),
              ),
              TextButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://github.com/altive/flutter_widgets/tree/main/packages/awaitable_button',
                    ),
                  );
                },
                child: const Text('Repository'),
              ),
            ],
          ),
          _Button(
            title: 'AwaitableElevatedButton',
            description: '''
Screen transition after processing is completed,
Success or Failure.''',
            useDivider: true,
            button: AwaitableElevatedButton<void>(
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
              child: const Text('Before pressing'),
            ),
          ),
          _Button(
            description: 'Can change the text being processed',
            button: AwaitableElevatedButton<void>(
              onPressed: () async {
                await Future<void>.delayed(const Duration(seconds: 2));
              },
              executingChild: const Text('Executing...'),
              child: const Text('Before pressing'),
            ),
          ),
          _Button(
            description: '''
Pass the result of processing to [whenComplete]. 
Success or Failure.''',
            button: AwaitableElevatedButton<String>(
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
              child: const Text('Before pressing'),
            ),
          ),
          _Button(
            description: '''
Handling Exceptions with [onError],
Success or Failure.''',
            button: AwaitableElevatedButton<void>(
              onPressed: () async {
                await Future<void>.delayed(const Duration(seconds: 2));
                if (Random().nextBool()) {
                  throw Exception();
                }
              },
              onError: (exception, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed.')),
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
              child: const Text('Before pressing'),
            ),
          ),
          _Button(
            title: 'AwaitableOutlinedButton',
            description: 'It is the same as [AwaitableElevatedButton] '
                'except for the style.',
            useDivider: true,
            button: AwaitableOutlinedButton<void>(
              onPressed: () async {
                await Future<void>.delayed(const Duration(seconds: 2));
              },
              executingChild: const Text('Executing...'),
              child: const Text('Before pressing'),
            ),
          ),
          _Button(
            title: 'AwaitableTextButton',
            description: 'It is the same as [AwaitableElevatedButton] '
                'except for the style.',
            useDivider: true,
            button: AwaitableTextButton<void>(
              onPressed: () async {
                await Future<void>.delayed(const Duration(seconds: 2));
              },
              executingChild: const Text('Executing...'),
              child: const Text('Before pressing'),
            ),
          ),
          if (widget.useMaterial3) ...[
            _Button(
              title: 'AwaitableFilledButton',
              description: 'It is the same as [AwaitableElevatedButton] '
                  'except for the style.',
              useDivider: true,
              button: AwaitableFilledButton<void>(
                onPressed: () async {
                  await Future<void>.delayed(const Duration(seconds: 2));
                },
                executingChild: const Text('Executing...'),
                child: const Text('Before pressing'),
              ),
            ),
            _Button(
              title: 'AwaitableFilledTonalButton',
              description: 'It is the same as [AwaitableElevatedButton] '
                  'except for the style.',
              useDivider: true,
              button: AwaitableFilledTonalButton<void>(
                onPressed: () async {
                  await Future<void>.delayed(const Duration(seconds: 2));
                },
                executingChild: const Text('Executing...'),
                child: const Text('Before pressing'),
              ),
            ),
          ],
          _Button(
            title: 'AwaitableIconButton',
            description: 'Success or Failure handling',
            useDivider: true,
            button: AwaitableIconButton<void>(
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
          ),
          _Button(
            description: 'Can change the icon being processed',
            button: AwaitableIconButton<void>(
              onPressed: () async {
                await Future<void>.delayed(const Duration(seconds: 1));
              },
              executingIcon: const Icon(Icons.timer_sharp),
              icon: const Icon(Icons.timer),
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    this.title,
    required this.description,
    required this.button,
    this.useDivider = false,
  });

  final String? title;
  final String description;
  final Widget button;
  final bool useDivider;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (useDivider) ...[
          const Divider(),
          const SizedBox(height: 32),
        ],
        if (title != null) ...[
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 16),
        ],
        Text(
          description,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(height: 16),
        button,
        const SizedBox(height: 32),
      ],
    );
  }
}
