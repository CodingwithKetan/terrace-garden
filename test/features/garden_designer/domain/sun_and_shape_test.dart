import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_templates.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout_validator.dart';
import 'package:terrace_garden/features/garden_designer/domain/sun_areas.dart';

LayoutElement el(
  String id,
  ElementKind kind,
  double x,
  double y, {
  double? w,
  double? h,
}) => LayoutElement(
  id: id,
  kind: kind,
  center: Vec2(x, y),
  width: w ?? kind.w,
  height: h ?? (kind.round ? (w ?? kind.w) : kind.h),
  depthCm: kind.depth,
);

LayoutDocument terrace(
  List<LayoutElement> elements, {
  double length = 400,
  double width = 300,
}) => LayoutDocument(
  gardenId: 'g',
  length: length,
  width: width,
  elements: elements,
);

void main() {
  group('sun areas', () {
    test('never conflict with anything', () {
      final doc = terrace([
        el('sun', ElementKind.sunFull, 100, 100),
        el('shade', ElementKind.shade, 150, 100),
        el('pot', ElementKind.roundPot, 100, 100),
        el('tank', ElementKind.waterTank, 150, 100),
      ]);
      expect(
        validateLayout(doc).where(
          (i) => i.elementId == 'sun' || i.elementId == 'shade',
        ),
        isEmpty,
      );
    });

    test('the topmost area covering a point gives its sun', () {
      final doc = terrace([
        el('sun', ElementKind.sunFull, 100, 100, w: 200, h: 200),
        el('shade', ElementKind.shade, 60, 60, w: 60, h: 60),
        el('pot', ElementKind.roundPot, 150, 150),
      ]);
      expect(sunAt(doc, const Vec2(60, 60)), SunExposure.lessThan3Hours);
      expect(sunAt(doc, const Vec2(150, 150)), SunExposure.moreThan6Hours);
      expect(sunAt(doc, const Vec2(350, 250)), isNull);
      expect(
        sunFor(doc, doc.elementById('pot')!),
        SunExposure.moreThan6Hours,
      );
    });

    test('maps each kind to the profile band', () {
      expect(sunExposureOf(ElementKind.sunPart), SunExposure.from3To6Hours);
      expect(sunExposureOf(ElementKind.roundPot), isNull);
    });
  });

  group('cut-outs', () {
    test('anything standing on one is outside the garden', () {
      final doc = terrace([
        el('cut', ElementKind.cutOut, 350, 50, w: 100, h: 100),
        el('pot', ElementKind.roundPot, 340, 40),
        el('sun', ElementKind.sunFull, 360, 60),
        el('ok', ElementKind.roundPot, 100, 100),
      ]);
      final issues = validateLayout(doc);
      expect(issues, hasLength(1));
      expect(issues.single.elementId, 'pot');
      expect(issues.single.type, IssueType.outOfBounds);
      expect(issues.single.severity, IssueSeverity.error);
    });

    test('reduce the usable floor in the summary', () {
      final doc = terrace([
        el('cut', ElementKind.cutOut, 350, 50, w: 100, h: 100),
      ]);
      expect(LayoutSummary.of(doc).gardenArea, 400 * 300 - 100 * 100);
    });

    test('sit under objects and over sun areas', () {
      final doc = terrace([
        el('arrow', ElementKind.northArrow, 20, 20),
        el('pot', ElementKind.roundPot, 100, 100),
        el('cut', ElementKind.cutOut, 350, 50),
        el('sun', ElementKind.sunFull, 100, 100),
      ]);
      expect(doc.drawOrder.map((e) => e.id), ['sun', 'cut', 'pot', 'arrow']);
      expect(ElementKind.cutOut.isBackground, isTrue);
      expect(ElementKind.northArrow.isBackground, isFalse);
    });
  });

  group('templates', () {
    var n = 0;
    String id() => 't${n++}';

    for (final (length, width) in [(300.0, 120.0), (400.0, 300.0)]) {
      for (final t in LayoutTemplate.values) {
        test('$t fits a $length × $width cm floor without errors', () {
          final elements = buildTemplate(
            t,
            length: length,
            width: width,
            newId: id,
          );
          expect(elements.where((e) => e.kind.isContainer), isNotEmpty);
          final doc = terrace(elements, length: length, width: width);
          expect(validateLayout(doc), isEmpty, reason: '$elements');
          expect(elements.map((e) => e.id).toSet(), hasLength(elements.length));
        });
      }
    }

    test('a wide floor gets two rows of bags with a path between', () {
      final elements = buildTemplate(
        LayoutTemplate.growBagRows,
        length: 400,
        width: 300,
        newId: id,
      );
      final ys = elements
          .where((e) => e.kind == ElementKind.roundGrowBag)
          .map((e) => e.center.y)
          .toSet();
      expect(ys, hasLength(2));
      expect(elements.where((e) => e.kind == ElementKind.path), hasLength(1));
    });

    test('nothing when the floor is too small', () {
      for (final t in LayoutTemplate.values) {
        expect(
          buildTemplate(t, length: 40, width: 20, newId: id),
          isEmpty,
        );
      }
    });
  });
}
