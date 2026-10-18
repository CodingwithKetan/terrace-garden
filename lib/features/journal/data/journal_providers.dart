import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/app/di/core_providers.dart';
import 'package:terrace_garden/core/database/database_provider.dart';
import 'package:terrace_garden/core/storage/storage_providers.dart';
import 'package:terrace_garden/features/journal/data/drift_journal_repository.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/features/journal/domain/journal_repository.dart';

part 'journal_providers.g.dart';

@Riverpod(keepAlive: true)
JournalRepository journalRepository(Ref ref) => DriftJournalRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(photoStorageProvider),
  ref.watch(clockProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(appLoggerProvider),
);

@riverpod
Stream<List<JournalEntry>> journalEntries(Ref ref) =>
    ref.watch(journalRepositoryProvider).watchAll();
