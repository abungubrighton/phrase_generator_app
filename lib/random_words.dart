import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  // Store all the favourite words
  final _savedWordPairs = <WordPair>{};
  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if (item.isOdd) return const Divider();

        final index = item ~/ 2;

        if (index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: const TextStyle(fontSize: 18.0),
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _savedWordPairs.remove(pair);
            } else {
              _savedWordPairs.add(pair);
            }
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      // creating a  list of tile widgets from the word pairs
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
            title: Text(
          pair.asPascalCase,
          style: const TextStyle(fontSize: 16.0),
        ));
      });

      // creating a list of Widgets(this is the list of Tile widgetd plus  some dividers)
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      // the Builder has to return something(could be the screen you want to display)
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Saved WordPairs",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.deepPurple[900],
          ),
          body: ListView(
            children: divided,
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "WordPair Generator",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.deepPurple[900],
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: _pushSaved,
                  color: Colors.white)
            ]),
        body: _buildList());
  }
}
