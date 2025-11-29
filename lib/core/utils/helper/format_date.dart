import 'package:intl/intl.dart';

String formatStandardDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return '';

  DateTime date = DateTime.parse(dateString).toLocal();

  return DateFormat('MMM d, y • h:mm a').format(date);
}