extension DateTimeExtensions on DateTime {
  String toMonthAndDate() {
    // Define an array with month abbreviations
    const monthAbbreviations = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    // Get the abbreviation for the current month
    String month = monthAbbreviations[this.month - 1];
    // Get the day of the month
    int day = this.day;

    // Return the formatted string
    return '$month $day';
  }
}