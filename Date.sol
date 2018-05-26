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

    function getDateTimeFromTimestamp(uint _timestamp) public pure returns (int year, uint8 month, uint8 day, uint8 hour, uint8 minute, uint8 second){
        second = uint8(_timestamp % 60);
        minute = uint8(_timestamp / 60 % 60);
        hour = uint8(_timestamp / 3600 % 24);

      uint daysSinceEpoch = _timestamp / 86400;
      daysSinceEpoch += 719468;
      int8 era = int8((daysSinceEpoch >= 0 ? daysSinceEpoch : daysSinceEpoch - 146096) / 146097);
      uint24 dayOfEra = uint24(int(daysSinceEpoch) - (int(era) * 146097));          // [0, 146096]
      uint16 yearOfEra = uint16(dayOfEra - dayOfEra/1460 + dayOfEra/36524 - dayOfEra/146096) / 365;  // [0, 399]
      year = int(int8(yearOfEra) + int(era) * 400);
      uint16 dayOfYear = uint16(dayOfEra - (365*yearOfEra + yearOfEra/4 - yearOfEra/100));                // [0, 365]
      uint8 auxiliaryMonth = uint8((5*dayOfYear + 2)/153);                                   // [0, 11]
      day = uint8(dayOfYear - uint16((153*uint16(auxiliaryMonth)+2)/5) + 1);                             // [1, 31]
      month = uint8(int8(auxiliaryMonth) + ((int8(auxiliaryMonth) < 10 ? int8(3) : -9)));                            // [1, 12]
      year = year + (month <= 2 ? 1 : 0);
    } 

    function getSeconds(uint _timestamp) pure public returns (uint8) {
      return uint8(_timestamp % 60);
    }

    function getMinute(uint _timestamp) pure public returns (uint8) {
      return uint8(_timestamp / 60) % 60;
    }

    function getHour(uint _timestamp) pure public returns (uint8) {
      return uint8(_timestamp / 60 / 60) % 24;
    }

    function isLeapYear(uint year) internal pure returns (bool) {
      return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
    }

   
}