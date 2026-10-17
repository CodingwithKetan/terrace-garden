import 'package:drift/drift.dart';
import 'package:terrace_garden/features/garden/data/garden_tables.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';

/// Placed layout elements; one layout per garden in the MVP. Geometry in cm
/// (ADR-017). Rows are deleted with their garden.
@DataClassName('LayoutElementRow')
class LayoutElements extends Table {
  TextColumn get id => text()();
  TextColumn get gardenId =>
      text().references(Gardens, #id, onDelete: KeyAction.cascade)();
  TextColumn get kind => textEnum<ElementKind>()();
  RealColumn get centerX => real()();
  RealColumn get centerY => real()();
  RealColumn get width => real()();
  RealColumn get height => real()();
  RealColumn get rotationDeg => real().withDefault(const Constant(0))();
  RealColumn get depthCm => real().nullable()();
  TextColumn get label => text().nullable()();

  /// Drawing order: higher draws on top.
  IntColumn get zIndex => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
