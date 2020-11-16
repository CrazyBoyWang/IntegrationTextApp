import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart';
import 'package:integrationTextApp/page/backpage/echo_page.dart';

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Text(wordPair.toString()),
    );
  }
}
