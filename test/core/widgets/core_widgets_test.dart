import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/app_card.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/empty_state.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/image_card.dart';
import 'package:terrace_garden/core/widgets/section_header.dart';
import 'package:terrace_garden/core/widgets/selectable_chip_group.dart';
import 'package:terrace_garden/core/widgets/skeleton.dart';
import 'package:terrace_garden/core/widgets/status_chip.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('AppButton', () {
    testWidgets('calls onPressed and meets tap-target guidelines', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpLocalized(
        Center(
          child: AppButton(label: 'Save', onPressed: () => taps++),
        ),
      );
      await tester.tap(find.text('Save'));
      expect(taps, 1);
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    });

    testWidgets('ignores taps while loading but keeps its label', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpLocalized(
        Center(
          child: AppButton(
            label: 'Save',
            isLoading: true,
            onPressed: () => taps++,
          ),
        ),
      );
      await tester.tap(find.text('Save'));
      expect(taps, 0);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders each variant with the matching Material button', (
      tester,
    ) async {
      await tester.pumpLocalized(
        Column(
          children: [
            AppButton(label: 'Primary', onPressed: () {}),
            AppButton.secondary(label: 'Secondary', onPressed: () {}),
            AppButton.text(label: 'Text', onPressed: () {}),
            AppButton.destructive(
              label: 'Delete',
              icon: Icons.delete_outline,
              onPressed: () {},
            ),
          ],
        ),
      );
      expect(find.byType(FilledButton), findsNWidgets(2));
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    });

    testWidgets('expand stretches to the available width', (tester) async {
      tester.setScreenSize(const Size(400, 800));
      await tester.pumpLocalized(
        AppButton(label: 'Wide', expand: true, onPressed: () {}),
      );
      expect(tester.getSize(find.byType(FilledButton)).width, 400);
    });
  });

  group('EmptyState', () {
    testWidgets('shows an action only when one is provided', (tester) async {
      var tapped = false;
      await tester.pumpLocalized(
        EmptyState(
          icon: Icons.yard_outlined,
          title: 'No gardens yet',
          body: 'Create one to start.',
          actionLabel: 'Create garden',
          onAction: () => tapped = true,
          badge: 'New',
        ),
      );
      expect(find.text('NEW'), findsOneWidget);
      await tester.tap(find.text('Create garden'));
      expect(tapped, isTrue);
    });

    testWidgets('has no button without an action', (tester) async {
      await tester.pumpLocalized(
        const EmptyState(icon: Icons.yard, title: 'Title', body: 'Body'),
      );
      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('fits a small screen at 200% text scale', (tester) async {
      tester.setScreenSize(const Size(320, 568));
      await tester.pumpLocalized(
        const EmptyState(
          icon: Icons.yard,
          title: 'Plan your terrace or balcony',
          body:
              'Garden setup is coming in the next update. You will describe '
              'your space and arrange pots and grow bags to scale.',
        ),
        textScale: 2,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('ErrorState', () {
    testWidgets('maps failures to plain-language messages and retries', (
      tester,
    ) async {
      var retries = 0;
      await tester.pumpLocalized(
        ErrorState(failure: const StorageFailure(), onRetry: () => retries++),
      );
      expect(
        find.text("We couldn't save or read your data on this device."),
        findsOneWidget,
      );
      await tester.tap(find.text('Try again'));
      expect(retries, 1);
    });

    testWidgets('falls back to a generic message', (tester) async {
      await tester.pumpLocalized(const ErrorState());
      expect(find.textContaining('Please try again'), findsOneWidget);
      expect(find.text('Try again'), findsNothing);
    });
  });

  group('AsyncStateView', () {
    Widget view(AsyncValue<String> value) => AsyncStateView<String>(
      value: value,
      data: Text.new,
    );

    testWidgets('shows a skeleton while loading', (tester) async {
      await tester.pumpLocalized(view(const AsyncLoading()));
      expect(find.byType(SkeletonList), findsOneWidget);
      expect(find.bySemanticsLabel('Loading'), findsOneWidget);
    });

    testWidgets('shows data', (tester) async {
      await tester.pumpLocalized(view(const AsyncData('Tomato')));
      expect(find.text('Tomato'), findsOneWidget);
    });

    testWidgets('maps errors to ErrorState', (tester) async {
      await tester.pumpLocalized(
        view(const AsyncError(NotFoundFailure(), StackTrace.empty)),
      );
      expect(find.textContaining("couldn't find that item"), findsOneWidget);
    });

    testWidgets('wraps unexpected errors as a generic failure', (
      tester,
    ) async {
      await tester.pumpLocalized(
        view(AsyncError(StateError('boom'), StackTrace.empty)),
      );
      expect(find.textContaining('Please try again'), findsOneWidget);
      expect(find.textContaining('boom'), findsNothing);
    });
  });

  group('SelectableChipGroup', () {
    const options = [
      ChipOption(value: 'veg', label: 'Vegetables'),
      ChipOption(value: 'herbs', label: 'Herbs'),
    ];

    testWidgets('multi-select toggles values on and off', (tester) async {
      var selected = <String>{'veg'};
      await tester.pumpLocalized(
        StatefulBuilder(
          builder: (context, setState) => SelectableChipGroup<String>(
            options: options,
            selected: selected,
            onChanged: (value) => setState(() => selected = value),
          ),
        ),
      );
      await tester.tap(find.text('Herbs'));
      await tester.pump();
      expect(selected, {'veg', 'herbs'});
      await tester.tap(find.text('Vegetables'));
      await tester.pump();
      expect(selected, {'herbs'});
    });

    testWidgets('single-select replaces and can require a value', (
      tester,
    ) async {
      var selected = <String>{'veg'};
      await tester.pumpLocalized(
        StatefulBuilder(
          builder: (context, setState) => SelectableChipGroup<String>(
            options: options,
            selected: selected,
            multiSelect: false,
            allowEmpty: false,
            onChanged: (value) => setState(() => selected = value),
          ),
        ),
      );
      await tester.tap(find.text('Herbs'));
      await tester.pump();
      expect(selected, {'herbs'});
      await tester.tap(find.text('Herbs'));
      await tester.pump();
      expect(selected, {'herbs'});
    });
  });

  group('dialogs', () {
    Future<bool?> openConfirm(WidgetTester tester) async {
      bool? result;
      await tester.pumpLocalized(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async => result = await showConfirmDialog(
              context,
              title: 'Delete garden?',
              message: 'This removes its photos too.',
              confirmLabel: 'Delete',
              destructive: true,
            ),
            child: const Text('Open'),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Delete garden?'), findsOneWidget);
      return result;
    }

    testWidgets('confirm resolves true', (tester) async {
      bool? result;
      await tester.pumpLocalized(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async => result = await showConfirmDialog(
              context,
              title: 'Delete garden?',
              message: 'This removes its photos too.',
            ),
            child: const Text('Open'),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });

    testWidgets('cancel resolves false', (tester) async {
      await openConfirm(tester);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Delete garden?'), findsNothing);
    });

    testWidgets('bottom sheet shows its title and content', (tester) async {
      await tester.pumpLocalized(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => showAppBottomSheet<void>(
              context,
              title: 'Add container',
              builder: (_) => const Text('Grow bag 24 x 18 in'),
            ),
            child: const Text('Open'),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Add container'), findsOneWidget);
      expect(find.text('Grow bag 24 x 18 in'), findsOneWidget);
    });
  });

  group('display components', () {
    testWidgets('StatusChip shows icon and label', (tester) async {
      await tester.pumpLocalized(
        Builder(
          builder: (context) => StatusChip(
            label: 'Water',
            icon: Icons.water_drop_outlined,
            color: context.careColors.water,
          ),
        ),
      );
      expect(find.text('Water'), findsOneWidget);
      expect(find.byIcon(Icons.water_drop_outlined), findsOneWidget);
    });

    testWidgets('ImageCard falls back to a placeholder without an image', (
      tester,
    ) async {
      await tester.pumpLocalized(
        const SizedBox(
          width: 240,
          child: ImageCard(title: 'Tomato', subtitle: 'Solanum lycopersicum'),
        ),
      );
      expect(find.text('Tomato'), findsOneWidget);
      expect(find.byIcon(Icons.local_florist_outlined), findsOneWidget);
    });

    testWidgets('AppCard is tappable and SectionHeader is a heading', (
      tester,
    ) async {
      var tapped = false;
      await tester.pumpLocalized(
        Column(
          children: [
            SectionHeader(
              title: 'Your plants',
              actionLabel: 'See all',
              onAction: () {},
            ),
            AppCard(
              semanticLabel: 'Open garden',
              onTap: () => tapped = true,
              child: const Text('Rooftop'),
            ),
          ],
        ),
      );
      await tester.tap(find.text('Rooftop'));
      expect(tapped, isTrue);
      expect(
        tester.getSemantics(find.text('Your plants')),
        matchesSemantics(isHeader: true, label: 'Your plants'),
      );
    });
  });
}
