extension ParseToString on Enum {
  String toShortString() {
    return toString().split('.').last;
  }

  String toHeadingString() {
    return toShortString()
        .replaceAll('_', ' ')
        .split(' ')
        .map((str) => str.toCapitalized())
        .join(' ');
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
