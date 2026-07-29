const List<String> incomeTypes = ['SAME_EVERY_PAYCHECK', 'FIXED', 'VARIABLE'];

const List<String> payFrequencies = [
  'WEEKLY',
  'EVERY_2_WEEKS',
  'TWICE_A_MONTH',
  'MONTHLY',
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
