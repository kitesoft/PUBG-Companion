class MonthHandler {
  static String nameToNumber(String monthName) {
    String _month;

    switch (monthName) {
      case 'Jan':
        _month = '01';
        break;
      case 'Feb':
        _month = '02';
        break;
      case 'Mar':
        _month = '03';
        break;
      case 'Apr':
        _month = '04';
        break;
      case 'May':
        _month = '05';
        break;
      case 'Jun':
        _month = '06';
        break;
      case 'Jul':
        _month = '07';
        break;
      case 'Aug':
        _month = '08';
        break;
      case 'Sep':
        _month = '09';
        break;
      case 'Oct':
        _month = '10';
        break;
      case 'Nov':
        _month = '11';
        break;
      case 'Dec':
        _month = '12';
        break;
      default:
        _month = '01';
        break;
    }

    return _month;
  }

  static String numberToName(int monthNumber) {
    String _month;

    switch (monthNumber) {
      case 1:
        _month = 'January';
        break;
      case 2:
        _month = 'February';
        break;
      case 3:
        _month = 'March';
        break;
      case 4:
        _month = 'April';
        break;
      case 5:
        _month = 'May';
        break;
      case 6:
        _month = 'June';
        break;
      case 7:
        _month = 'July';
        break;
      case 8:
        _month = 'August';
        break;
      case 9:
        _month = 'September';
        break;
      case 10:
        _month = 'October';
        break;
      case 11:
        _month = 'November';
        break;
      case 12:
        _month = 'December';
        break;
      default:
        _month = 'Jan';
        break;
    }

    return _month;
  }
}
