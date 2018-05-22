pragma solidity ^0.4.23;


contract Date {
    uint public secs;
    string public dateString;
    uint public year;
    uint public month;
    uint public day;
    uint public hour;
    uint public minute;
    uint public second;
    
    constructor(uint _secondsSinceEpoch) public {
        secs = _secondsSinceEpoch;
        second = secs % 60;
        minute = (secs / 60) % 60;
        hour = (secs / 60 / 60) % 24;

        uint daysSinceEpoch = secs / 60 / 60 / 24;
        uint _days = daysSinceEpoch;
        uint _year = 1970;

        while (_days >= 366) {
          if(isLeapYear(_year)) {
            _days = _days - 366;
          } else {
            _days = _days - 365;
          }
          _year = _year + 1;
        }

        year = _year;
        
        if(!isLeapYear(_year)){
          if(_days < 31) {
            month = 1;
            day =_days +1;
            return;
          }
          if(_days < 59) {
            month = 2;
            day =_days - 30;
            return;
          }
          if(_days < 90) {
            month = 3;
            day =_days - 58;
            return;
          }
          if(_days < 120) {
            month = 4;
            day =_days - 89;
            return;
          }
          if(_days < 151) {
            month = 5;
            day =_days - 119;
            return;
          }
          if(_days < 181) {
            month = 6;
            day =_days - 150;
            return;
          }
          if(_days < 212) {
            month = 7;
            day =_days - 180;
            return;
          }
          if(_days < 243) {
            month = 8;
            day =_days - 211;
            return;
          }
          if(_days < 273) {
            month = 9;
            day =_days - 242;
            return;
          }
          if(_days < 304) {
            month = 10;
            day =_days - 272;
            return;
          }
          if(_days < 334) {
            month = 11;
            day =_days - 303;
            return;
          }
          if(_days < 365) {
            month = 12;
            day =_days - 333;
            return;
          }
        }

        if(_days < 31) {
            month = 1;
            day =_days +1;
            return;
          }
          if(_days < 60) {
            month = 2;
            day =_days - 30;
            return;
          }
          if(_days < 91) {
            month = 3;
            day =_days - 59;
            return;
          }
          if(_days < 121) {
            month = 4;
            day =_days - 90;
            return;
          }
          if(_days < 152) {
            month = 5;
            day =_days - 120;
            return;
          }
          if(_days < 182) {
            month = 6;
            day =_days - 151;
            return;
          }
          if(_days < 213) {
            month = 7;
            day =_days - 181;
            return;
          }
          if(_days < 244) {
            month = 8;
            day =_days - 212;
            return;
          }
          if(_days < 274) {
            month = 9;
            day =_days - 243;
            return;
          }
          if(_days < 305) {
            month = 10;
            day =_days - 273;
            return;
          }
          if(_days < 335) {
            month = 11;
            day =_days - 304;
            return;
          }
          if(_days < 366) {
            month = 12;
            day =_days - 334;
            return;
          }
    }

    function isLeapYear(uint year) pure returns (bool) {
      return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
    }
    
    function weeksSinceEpoch() view returns (uint) {
        return secs / 604800;
    }
    
    function daysSinceEpoch() view returns (uint) {
        return secs / 86400;
    }
    
    function hoursSinceEpoch() view returns (uint) {
        return secs / 3600;
    }

    function minutesSinceEpoch() view returns (uint) {
        return secs / 60;
    }

    function secondsSinceEpoch() view returns (uint) {
        return secs;
    }
}