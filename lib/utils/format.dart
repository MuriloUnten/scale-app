/*
 * Takes a DateTime and returns a string in the form dd/mm/YYYY
*/
String formatDate(DateTime date) {
    String day = date.day.toString();
    if (date.day < 10) {
        day = "0$day";
    }
    String month = date.month.toString();
    if (date.month < 10) {
        month = "0$month";
    }
    return "$day/$month/${date.year}";
}

/*
 * takes a string in the form dd/mm/YYYY and returns the equivalent DateTime
*/
DateTime parseFormattedDate(String formattedDate) {
    List<String> parts = formattedDate.split("/");
    return DateTime.parse("${parts[2]}-${parts[1]}-${parts[0]}");
}
