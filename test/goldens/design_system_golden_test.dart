import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_theme.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/app_card.dart';
import 'package:terrace_garden/core/widgets/image_card.dart';
import 'package:terrace_garden/core/widgets/status_chip.dart';

void main() {
  for (final (name, theme) in [
    ('light', AppTheme.light()),
    ('dark', AppTheme.dark()),
  ]) {
    Widget themed(Widget child) => Theme(
      data: theme,
      child: ColoredBox(
        color: theme.colorScheme.surface,
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    );

    unawaited(
      goldenTest(
        'design-system components ($name)',
        fileName: 'design_system_$name',
        builder: () => GoldenTestGroup(
          columns: 2,
          children: [
            GoldenTestScenario(
              name: 'buttons',
              child: themed(
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton(label: 'Primary', onPressed: () {}),
                    const SizedBox(height: 8),
                    AppButton.secondary(label: 'Secondary', onPressed: () {}),
                    const SizedBox(height: 8),
                    AppButton.text(label: 'Text', onPressed: () {}),
                    const SizedBox(height: 8),
                    AppButton.destructive(label: 'Delete', onPressed: () {}),
                    const SizedBox(height: 8),
                    const AppButton(label: 'Disabled', onPressed: null),
                  ],
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'status chips',
              child: themed(
                Builder(
                  builder: (context) {
                    final care = context.careColors;
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        StatusChip(
                          label: 'Water',
                          icon: Icons.water_drop_outlined,
                          color: care.water,
                        ),
                        StatusChip(
                          label: 'Fertilise',
                          icon: Icons.compost_outlined,
                          color: care.fertilise,
                        ),
                        StatusChip(
                          label: 'Harvest',
                          icon: Icons.restaurant_outlined,
                          color: care.harvest,
                        ),
                        StatusChip(
                          label: 'Inspect',
                          icon: Icons.search,
                          color: care.inspect,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'cards',
              child: themed(
                SizedBox(
                  width: 220,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppCard(
                        onTap: () {},
                        child: const Text('Rooftop garden'),
                      ),
                      const SizedBox(height: 12),
                      const ImageCard(
                        title: 'Tomato',
                        subtitle: 'Solanum lycopersicum',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
