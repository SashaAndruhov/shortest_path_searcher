import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shortest_path_searcher/common/routing/routing.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/processing_result_model.dart';

class ResultListPage extends StatelessWidget {
  const ResultListPage({super.key, required this.results});

  final List<ProcessingResultModel> results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result list screen')),
      body: SafeArea(
        child: results.isEmpty
            ? const Center(child: Text('No results'))
            : ListView.separated(
                itemCount: results.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final result = results[index];
                  return InkWell(
                    onTap: () => context.pushNamed(
                      RouteName.previewScreen,
                      extra: result,
                    ),
                    child: SizedBox(
                      height: 64,
                      child: Center(
                        child: Text(
                          result.result.displayPath,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

}
