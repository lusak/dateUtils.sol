pragma solidity ^0.4.23;


contract DateAndTime {

    struct DateTime {
      int timestamp;
      int year;
      uint8 month;
      uint8 day;
      uint8 hour;
      uint8 minute;
      uint8 second;
    }
    
    function getDateTimeFromTimestamp(int _timestamp) public pure returns (
        int year,
        uint8 month,
        uint8 day,
        uint8 hour,
        uint8 minute,
        uint8 second
    )
    {
        if(_timestamp>0){
            second = uint8(_timestamp % 60);
            minute = uint8((_timestamp / 60 % 60));
            hour = uint8(_timestamp / 3600 % 24);

        } else {
            int nh = _timestamp % 86400;
            second = uint8((86400 + nh) % 60);
            minute = uint8((86400 + nh) / 60 % 60);
            hour = uint8((86400 + nh) / 3600 % 24);
        }

        int dse = (_timestamp < 0 ? (_timestamp / 86400 - 1) : _timestamp / 86400);
        dse += 719468;
        int era = int8((dse >= 0 ? dse : dse - 146096) / 146097);
        int doe = dse - era * 146097;
        int yoe = (doe - doe/1460 + doe/36524 - doe/146096) / 365;
        year = yoe + era * 400;
        int doy = doe - (365*yoe + yoe/4 - yoe/100);
        int mh = (5*doy + 2)/153;
        day = uint8(doy - (153*mh+2)/5 + 1);
        month = uint8((mh < 10 ? (mh + 3) : (mh -9)));
        year = year + (month <= 2 ? 1 : 0);
    } 

    function isLeapYear(uint year) public pure returns (bool) {
      return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
    }
}