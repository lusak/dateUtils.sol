pragma solidity ^0.4.23;


contract DateAndTime {

    struct DateTime {
      uint timestamp;
      uint16 year;
      uint8 month;
      uint8 day;
      uint8 hour;
      uint8 minute;
      uint8 second;
    }

    function getDateTimeFromTimestamp(int _timestamp) public pure returns (
        int year,
        int month,
        int day,
        int8 hour,
        int8 minute,
        int8 second
    )
    {
        if(_timestamp<0){
            second = 60 + int8(_timestamp % 60);
            minute = 60 + int8(_timestamp / 60 % 60) - 1;
            hour = 24 + int8(_timestamp / 3600 % 24)-  1;
        } else {
            second = int8(_timestamp % 60);
            minute = int8(_timestamp / 60 % 60);
            hour = int8(_timestamp / 3600 % 24);
        }

        int daysSinceEpoch = (_timestamp < 0 ? (_timestamp / 86400 - 1) : _timestamp / 86400);
        daysSinceEpoch += 719468;
        int era = int8((daysSinceEpoch >= 0 ? daysSinceEpoch : daysSinceEpoch - 146096) / 146097);
        int dayOfEra = daysSinceEpoch - era * 146097;
        int yearOfEra = (dayOfEra - dayOfEra/1460 + dayOfEra/36524 - dayOfEra/146096) / 365;
        year = yearOfEra + era * 400;
        int dayOfYear = dayOfEra - (365*yearOfEra + yearOfEra/4 - yearOfEra/100);
        int auxiliaryMonth = (5*dayOfYear + 2)/153;
        day = dayOfYear - (153*auxiliaryMonth+2)/5 + 1;
        month = (auxiliaryMonth < 10 ? (auxiliaryMonth + 3) : (auxiliaryMonth -9));
        year = year + (month <= 2 ? 1 : 0);
    } 

    function isLeapYear(uint year) internal pure returns (bool) {
      return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
    }
}