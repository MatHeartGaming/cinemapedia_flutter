import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initialLoadingActorsProvider = Provider<bool>(
  (ref) {
    final step1 = ref.watch(actorsByMovieProvider).isEmpty;
    return step1;
  },
);