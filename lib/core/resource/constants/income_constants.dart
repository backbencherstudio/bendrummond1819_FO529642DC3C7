const List<String> incomeTypes = ['SAME_EVERY_PAYCHECK', 'VARIES_A_LITTLE', 'VARIES_A_LOT'];

const List<String> payFrequencies = [
  'WEEKLY',
  'EVERY_2_WEEKS',
  'TWICE_A_MONTH',
  'MONTHLY',
  'INCONSISTENT',
];

String formatEnumLabel(String value) {
  return value
      .replaceAll('_', ' ')
      .split(' ')
      .map(
        (w) => w.isNotEmpty
            ? '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}'
            : '',
      )
      .join(' ');
}
