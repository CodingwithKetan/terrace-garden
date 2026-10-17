import 'package:flutter/material.dart';
import 'package:terrace_garden/core/widgets/empty_state.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// JRN-01. The progress journal arrives in Phase 6.
class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navJournal)),
      body: EmptyState(
        icon: Icons.photo_library_outlined,
        title: l10n.journalEmptyTitle,
        body: l10n.journalEmptyBody,
        badge: l10n.comingSoonLabel,
      ),
    );
  }
}
