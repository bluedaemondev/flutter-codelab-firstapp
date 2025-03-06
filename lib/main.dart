import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    print("You are requesting a new WordPair");
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var currentPair = appState.current;

    return Scaffold(
        body: SizedBox.expand(
            child: Column(
      children: [
        Text('My Awesome Random Incredible idea:'),
        BigCard(currentPair: currentPair),
        ElevatedButton(
            onPressed: () {
              appState.getNext();
            },
            child: Text('Next')),
      ],
    )));
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.currentPair,
  });

  final WordPair currentPair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primary,    // ← And also this.
      child: Padding(
        padding: const EdgeInsets.all(200),
        child: Text(currentPair.asLowerCase),
      ),
    );

    // return Text(currentPair.asLowerCase);
  }
}
