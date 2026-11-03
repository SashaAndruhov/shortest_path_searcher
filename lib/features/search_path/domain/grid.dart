import 'package:shortest_path_searcher/features/search_path/domain/point.dart';

const _blockedCell = 'X';

class Grid {
  Grid.fromRows(List<String> rows) : _rows = List.unmodifiable(rows);

  static const List<Point> _directions = [
    Point(-1, -1),
    Point(0, -1),
    Point(1, -1),
    Point(-1, 0),
    Point(1, 0),
    Point(-1, 1),
    Point(0, 1),
    Point(1, 1),
  ];

  final List<String> _rows;

  int get height => _rows.length;

  int get width => _rows.isEmpty ? 0 : _rows.first.length;

  bool contains(Point point) =>
      point.y >= 0 && point.y < height && point.x >= 0 && point.x < _rows[point.y].length;

  bool isBlocked(Point point) => _rows[point.y][point.x] == _blockedCell;

  Iterable<Point> neighbours(Point point) => _directions
      .map((direction) => point + direction)
      .where((neighbour) => contains(neighbour) && !isBlocked(neighbour));
}
