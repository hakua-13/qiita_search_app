import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import 'package:qiita_search/models/article.dart';

part 'articles_provider.g.dart';

@riverpod
class Articles extends _$Articles {
  @override
  List<Article> build() {
    return [];
  }

  Future<void> searchQiita(String keyword) async {
    final uri = Uri.http('qiita.com', '/api/v2/items', {
      'query': 'title:$keyword',
      'per_page': '10',
    });

    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';
    final http.Response res = await http.get(uri, headers: {
      'Authrization': 'Bearer $token',
    });

    if(res.statusCode == 200) {
      final List<dynamic> body = jsonDecode(res.body);
      state =  body.map((dynamic json) => Article.fromJson(json))
      .toList();
    } else {
      state = [];
    }
  }
}