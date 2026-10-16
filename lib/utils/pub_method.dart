import 'dart:io';

import 'package:flutter/services.dart';
import 'package:woodenfish/plugin/method_plugin.dart';
import 'package:woodenfish/utils/toast_util.dart';
import 'package:in_app_review/in_app_review.dart';

import 'platform_utils.dart';
import 'trie_note.dart';

class PubMethodUtils {
  static void parseSensitiveWordsTxt(String filePath) async {
    try {
      File file = File(filePath);
      if (await file.exists()) {
        List<String> lines = await file.readAsLines();
        List<String> sensitiveWords = [];
        for (String line in lines) {
          RegExp regExp = RegExp(r'\b(\w+)\b');
          Iterable<Match> matches = regExp.allMatches(line);
          for (Match match in matches) {
            var word = match.group(0)!;
            sensitiveWords.add(word);
          }
        }
        for (String word in sensitiveWords) {
          print(word);
        }
      } else {
        print('File not found.');
      }
    } catch (e) {
      print('Error reading file: $e');
    }
  }

  static Future<Trie> parseSensitiveWords() async {
    String fileContent = await rootBundle.loadString('assets/mgc.txt');
    List<String> sensitiveWords = fileContent.split('\r\n');
    Trie trie = Trie();
    for (var element in sensitiveWords) {
      trie.insert(element);
    }
    return trie;
  }

  static Future<AhoCorasick> parseSensitiveWords1() async {
    String fileContent = await rootBundle.loadString('assets/mgc.txt');
    List<String> sensitiveWords = fileContent.split('\r\n');
    var ahoCorasick = AhoCorasick();
    for (var element in sensitiveWords) {
      ahoCorasick.insert(element);
    }
    ahoCorasick.buildFailureLinks();
    return ahoCorasick;
  }

  static bool parseSearch(String content, Trie trie) {
    List<String> words = content.split(' ');
    for (String word in words) {
      if (trie.search(word)) {
        return true;
      }
    }
    return false;
  }
}
