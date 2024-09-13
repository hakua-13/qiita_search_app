import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qiita_search/provider/articles_provider.dart';
import 'package:qiita_search/widgets/article_container.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articlesProvider);
    final articlesNotifier = ref.watch(articlesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: '検索ワードを入力してください',
              ),
              onSubmitted: (String value) async {
                await articlesNotifier.searchQiita(value);
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: articles
                .map((article) => ArticleContainer(article: article))
                .toList(),
            ),
          ),
        ],
      ),
    );
  }

}