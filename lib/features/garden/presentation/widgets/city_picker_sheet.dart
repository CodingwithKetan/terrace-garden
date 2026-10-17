import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// Result of the city picker; [city] is null when the user chose "No city".
class CityChoice {
  const CityChoice(this.city);

  final City? city;
}

/// Opens an offline, searchable city list. Resolves to null if dismissed.
Future<CityChoice?> showCityPicker(BuildContext context) {
  final l10n = context.l10n;
  return showAppBottomSheet<CityChoice>(
    context,
    title: l10n.fieldCity,
    builder: (context) => const _CityPicker(),
  );
}

class _CityPicker extends StatefulWidget {
  const _CityPicker();

  @override
  State<_CityPicker> createState() => _CityPickerState();
}

class _CityPickerState extends State<_CityPicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final results = searchCities(_query);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: l10n.citySearchHint,
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: (value) => setState(() => _query = value),
        ),
        const SizedBox(height: AppSpacing.sm),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.location_off_outlined),
          title: Text(l10n.cityClear),
          onTap: () => Navigator.of(context).pop(const CityChoice(null)),
        ),
        if (results.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(l10n.cityNoResults, style: theme.textTheme.bodyMedium),
          ),
        for (final city in results)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.location_city_outlined),
            title: Text(city.name),
            subtitle: Text(city.state),
            onTap: () => Navigator.of(context).pop(CityChoice(city)),
          ),
      ],
    );
  }
}
