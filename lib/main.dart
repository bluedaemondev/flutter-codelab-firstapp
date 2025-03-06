import 'dart:math';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favWords = <WordPair>[];

  void getNext() {
    print("You are requesting a new WordPair");
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favWords.contains(current)) {
      favWords.remove(current);
    } else {
      favWords.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var currentPair = appState.current;
    IconData icon;
    if (appState.favWords.contains(currentPair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }


    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Look at my app, you'),
          BigCard(currentPair: currentPair),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like')),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next')),
            ],
          ),
        ],
      ),
    ));
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
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          currentPair.asLowerCase,
          style: style,
          semanticsLabel:
              "${currentPair.first} ${currentPair.second}", // Semantic labels ensure correct interpretation for accessibility features
        ),
      ),
    );

    // return Text(currentPair.asLowerCase);
  }
}
