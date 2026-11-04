import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/processing_field_model.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/processing_result_model.dart';
import 'package:shortest_path_searcher/features/search_path/domain/grid.dart';
import 'package:shortest_path_searcher/features/search_path/domain/point.dart';
import 'package:shortest_path_searcher/features/search_path/presentation/managers/home_page_cubit.dart';

enum _CellType {

  start(Color(0xFF64FFDA)),
  end(Color(0xFF009688)),
  blocked(Color(0xFF000000)),
  path(Color(0xFF4CAF50)),
  empty(Color(0xFFFFFFFF));

  const _CellType(this.color);

  final Color color;
}

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.result});

  final ProcessingResultModel result;

  @override
  Widget build(BuildContext context) {
    final field = context
        .read<HomePageCubit>()
        .state
        .fields
        .where((field) => field.id == result.id)
        .firstOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (field == null)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Field not found', textAlign: TextAlign.center),
                )
              else
                _PathGrid(field: field, result: result),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  result.result.displayPath,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class _PathGrid extends StatelessWidget {
  const _PathGrid({required this.field, required this.result});

  final ProcessingFieldModel field;
  final ProcessingResultModel result;

  @override
  Widget build(BuildContext context) {
    final grid = Grid.fromRows(field.field);
    if (grid.width == 0 || grid.height == 0) return const Text('Empty field');

    final start = Point(field.start.x, field.start.y);
    final end = Point(field.end.x, field.end.y);
    final pathPoints = {
      for (final step in result.result.steps ?? const []) Point(step.x, step.y),
    };

    _CellType cellType(Point point) {
      if (point == start) return _CellType.start;
      if (point == end) return _CellType.end;
      if (grid.isBlocked(point)) return _CellType.blocked;
      if (pathPoints.contains(point)) return _CellType.path;
      return _CellType.empty;
    }

    return AspectRatio(
      aspectRatio: grid.width / grid.height,
      child: Column(
        children: [
          for (var y = 0; y < grid.height; y++)
            Expanded(
              child: Row(
                children: [
                  for (var x = 0; x < grid.width; x++)
                    Expanded(
                      child: _GridCell(
                        point: Point(x, y),
                        type: grid.contains(Point(x, y)) ? cellType(Point(x, y)) : _CellType.empty,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

}

class _GridCell extends StatelessWidget {
  const _GridCell({required this.point, required this.type});

  final Point point;
  final _CellType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: type.color,
        border: Border.all(color: Colors.black54, width: 0.5),
      ),
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '(${point.x},${point.y})',
          style: TextStyle(
            fontSize: 12,
            color: type == _CellType.blocked ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

}
