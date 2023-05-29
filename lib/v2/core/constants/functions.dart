import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

/// [Function] that converts any timestamp to
/// our desired output as the timestamp is in
/// another format.
String convertTimeStampToTimeFormat(String date) {
  var outputFormat = DateFormat('yyyy-MM-dd hh:mm');
  return outputFormat.format(DateTime.parse(
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date).toString()));
}

String convertCurrentTimeStampToTimeFormat() {
  tz.initializeTimeZones();
  var seoul = tz.getLocation('Asia/Seoul');
  var date = tz.TZDateTime.now(seoul).toString().split('.')[0];
  var outputFormat = DateFormat('yyyy-MM-dd hh:mm a');
  return outputFormat.format(
      DateTime.parse(DateFormat("yyyy-MM-dd HH:mm:ss").parse(date).toString()));
}

/// [Function] that converts the [Order] timestamp to
/// our desired output as the [Order] timestamp is in
/// another format.
String convertOrderTimeStampToTimeFormat(String date) {
  var outputFormat = DateFormat('MMM-dd-yyyy hh:mm:ss a');
  return outputFormat.format(DateTime.parse(
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date).toString()));
}

String convertTimeStampToTime(DateTime date) {
  return DateFormat.Hms().format(date);
}

String convertTimeStampToTimeWithSecsFormat(String date) {
  if (date.isNotEmpty) {
    var outputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    return outputFormat.format(DateTime.parse(
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date).toString()));
  }
  return "";
}

String priceString(String numberString) {
  final numberDigits = List.from(numberString.split(''));
  int index = numberDigits.length - 3;
  while (index > 0) {
    numberDigits.insert(index, ',');
    index -= 3;
  }
  return numberDigits.join();
}

String performDivisionOnStringAndInt(String first, int second) {
  int value = int.parse(first.replaceAll(',', ''));
  return NumberFormat('#,###').format((value / second).ceil());
}

String performMultiplyOnStringAndInt(String first, double second) {
  int value = int.parse(first.replaceAll(',', ''));
  return NumberFormat('#,###').format((value * second).toInt());
}

String performAdditionOnStringAndInt(String first, int second) {
  int value = int.parse(first.replaceAll(',', ''));
  return NumberFormat('#,###').format(value + second);
}

deprecatedConvertAmountToWon(num) {
  int number = int.parse(num);
  if (number >= 1000000) {
    if (number == 1000000000) {
      return '10억원';
    }
    if (number == 100000000) {
      return '1억원';
    }
    int numberPerHundredMillion = number ~/ 1000000;
    var result = '';
    int firstSection =
        numberPerHundredMillion > 100 ? numberPerHundredMillion ~/ 100 : 0;
    if (firstSection > 0) {
      result += "$firstSection억 ";
    }
    var secondSection =
        "${(number - (firstSection * 1000000 * 100)) ~/ 10000}만원";

    return result != '' ? result += secondSection : secondSection;
  } else {
    return '0만원';
  }
}

convertAmountToWon(num) {
  int number = int.parse(num);
  var temp = number ~/ 100000000;
  var result = '';
  if (number == 0) {
    return '0 원';
  }
  if (temp > 0) {
    result += '$temp 억 ';
    number = number % 100000000;
  }
  temp = number ~/ 10000;
  if (temp > 0) {
    result += '$temp 만 ';
    number = number % 10000;
  }
  if (number > 0) {
    result += '$number';
  }
  return "$result원";
}
