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

    function getTimestampFromDateTime(
        int year, 
        int month, 
        int day, 
        int hour, 
        int minute, 
        int second
    ) 
        public pure returns(
        int
    )
    {
        year -= (month <= 2 ? 1 : 0);
        int era = (year >= 0 ? year : year-399) / 400;
        int yoe = year - era * 400; 
        month = month > 2 ? month -3 : month + 9;
        int doy = ((month*153) + 2)/5 + day-1;
        int doe = yoe * 365 + yoe/4 - yoe/100 + doy;
        int dfe = era * 146097 + doe - 719468;
        return dfe * 86400 + 3600 * hour + 60 * minute + second;

    }

    function getDateTimeObjectFromTimestamp(int _timestamp) internal pure returns(DateTime dt)
    {
        if(_timestamp>0){
            dt.second = uint8(_timestamp % 60);
            dt.minute = uint8((_timestamp / 60 % 60));
            dt.hour = uint8(_timestamp / 3600 % 24);

        } else {
            int nh = _timestamp % 86400;
            dt.second = uint8((86400 + nh) % 60);
            dt.minute = uint8((86400 + nh) / 60 % 60);
            dt.hour = uint8((86400 + nh) / 3600 % 24);
        }

        int dse = (_timestamp < 0 ? (_timestamp / 86400 - 1) : _timestamp / 86400);
        dse += 719468;
        int era = (dse >= 0 ? dse : dse - 146096) / 146097;
        int doe = dse - era * 146097;
        int yoe = (doe - doe/1460 + doe/36524 - doe/146096) / 365;
        int doy = doe - (365*yoe + yoe/4 - yoe/100);
        int mh = (5*doy + 2)/153;
        dt.day = uint8(doy - (153*mh+2)/5 + 1);
        dt.month = uint8((mh < 10 ? (mh + 3) : (mh -9)));
        dt.year = yoe + era * 400 + (dt.month <= 2 ? 1 : 0);
    }

    function getTimeFromTimestamp(int _timestamp) public pure returns(
        int hour,
        int minute,
        int second
    )
    {
        if(_timestamp>0){
            second = _timestamp % 60;
            minute = (_timestamp / 60 % 60);
            hour = _timestamp / 3600 % 24;

        } else {
            int nh = _timestamp % 86400;
            second = (86400 + nh) % 60;
            minute = (86400 + nh) / 60 % 60;
            hour = (86400 + nh) / 3600 % 24;
        }
    }

    function getDateFromTimestamp(int _timestamp) public pure returns(
        int year,
        int month,
        int day
    )
    {
        int dse = (_timestamp < 0 ? (_timestamp / 86400 - 1) : _timestamp / 86400);
        dse += 719468;
        int era = (dse >= 0 ? dse : dse - 146096) / 146097;
        int doe = dse - era * 146097;
        int yoe = (doe - doe/1460 + doe/36524 - doe/146096) / 365;
        int doy = doe - (365*yoe + yoe/4 - yoe/100);
        int mh = (5*doy + 2)/153;
        day = doy - (153*mh+2)/5 + 1;
        month = (mh < 10 ? (mh + 3) : (mh -9));
        year = yoe + era * 400 + (month <= 2 ? 1 : 0);
    }
    
    function getDateTimeFromTimestamp(int _timestamp) public pure returns (
        int year,
        int month,
        int day,
        int hour,
        int minute,
        int second
    )
    {
        if(_timestamp>0){
            second = _timestamp % 60;
            minute = _timestamp / 60 % 60;
            hour = _timestamp / 3600 % 24;

        } else {
            int nh = _timestamp % 86400;
            second = (86400 + nh) % 60;
            minute = (86400 + nh) / 60 % 60;
            hour = (86400 + nh) / 3600 % 24;
        }

        int dse = (_timestamp < 0 ? (_timestamp / 86400 - 1) : _timestamp / 86400);
        dse += 719468;
        int era = (dse >= 0 ? dse : dse - 146096) / 146097;
        int doe = dse - era * 146097;
        int yoe = (doe - doe/1460 + doe/36524 - doe/146096) / 365;
        int doy = doe - (365*yoe + yoe/4 - yoe/100);
        int mh = (5*doy + 2)/153;
        day = doy - (153*mh+2)/5 + 1;
        month = (mh < 10 ? (mh + 3) : (mh -9));
        year = yoe + era * 400 + (month <= 2 ? 1 : 0);
    } 

    function isLeapYear(uint year) internal pure returns (bool) {
      return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
    }
}