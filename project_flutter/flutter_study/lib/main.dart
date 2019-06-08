import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          // child: new Text('Hello World'),
          // child: new Text(wordPair.asPascalCase),
          child: new RandomWords(),
        ),
      ),
    );
  }
}

/*
上面的 Stateless widgets 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
 Stateful widgets 持有的状态可能在widget生命周期中发生变化. 实现一个 stateful widget 至少需要两个类:
 一个 StatefulWidget类
 一个 State类
 StatefulWidget类本身是不变的，但是 State类在widget生命周期中始终存在. 
*/
class RandomWords extends StatefulWidget {
  // 继承自StatefulWidget 仅负责创建State
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  // 继承自StatefulWidget 创建好的State 进行操作 大部分代码都在该类中实现
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);          // 简单的生成单词组

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestiongs(),
    );
  }

  // 继续扩展 RandomWordsState 实现一个无限滚动的list
// 1、_ 开头为dart 语法私有变量  创建一个数组和 字体属性
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // 2、添加 _buildSuggestions() 函数 用于构建显示单词的listView
  Widget _buildSuggestiongs() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider(); // 如果为奇数 返回一个高为1像素的分割线widget
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
