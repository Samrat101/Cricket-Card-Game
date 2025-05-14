enum ComparisionWin {
  lower('lower'),
  greater('greater');

  const ComparisionWin(this.value);
  final String value;

  static ComparisionWin from(String rawValue) {
    return ComparisionWin.values.firstWhere(
      (element) => element.value == rawValue,
      orElse: () => ComparisionWin.greater,
    );
  }
}

enum ComparisonOutcome { win, loss, tie }
