import 'dart:collection';

import 'package:shortest_path_searcher/features/search_path/domain/grid.dart';
import 'package:shortest_path_searcher/features/search_path/domain/point.dart';

class ShortestPathFinder {
  const ShortestPathFinder();

  List<Point>? find(Grid grid, Point start, Point end) {
    if (!grid.contains(start) || !grid.contains(end)) return null;
    if (grid.isBlocked(start) || grid.isBlocked(end)) return null;
    if (start == end) return [start];

    final queue = ListQueue<Point>()..add(start);
    final cameFrom = <Point, Point>{};
    final visited = <Point>{start};

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      for (final neighbour in grid.neighbours(current)) {
        if (!visited.add(neighbour)) continue;
        cameFrom[neighbour] = current;
        if (neighbour == end) return _buildPath(cameFrom, end);
        queue.add(neighbour);
      }
    }
    return null;
  }

  List<Point> _buildPath(Map<Point, Point> cameFrom, Point end) {
    final path = <Point>[end];
    var current = end;
    while (cameFrom.containsKey(current)) {
      current = cameFrom[current]!;
      path.add(current);
    }
    return path.reversed.toList();
  }
}
