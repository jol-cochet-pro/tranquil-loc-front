enum SearchState { searching, paused }

extension SearchStateExtension on SearchState {
  String get str {
    switch (this) {
      case SearchState.paused:
        return "paused";
      case SearchState.searching:
        return "searching";
    }
  }
}
