'
' Utils to work with dates and times
' @singleton
' @returns {Object} the buArrayUtils singleton
' @license MIT
' @functions
' * compare
' * isBetween
' * isAfter
' * isBefore
' * dateOf
' * parse
' * toMidnight
' * duration
' * addDays
' * addHours
' * substractDays
' * substractHours
' * toString
function buDateTimeUtils() as Object
    if(m.buDateTimeUtils = Invalid) then
        m.buDateTimeUtils = {

            ' Compares two roDateTimes
            ' @param {roDateTime} date1 - the first roDateTime to compare
            ' @param {roDateTime} date2 - the second roDateTime to compare
            ' @returns {Integer} 1 if date1 > date2. 0 if they are the same. -1 if date1 < date2.
            compare: function(date1 as Object, date2 as Object) as Integer
                sd1 = date1.asSeconds()
                sd2 = date2.asSeconds()

                if sd1 < sd2 then
                    return -1
                else if sd1 > sd2 then
                    return 1
                else
                    return 0
                end if
            end function,

            ' Compares three dates to know if it's between them
            ' @param {Object} startDateTime - when the range starts
            ' @param {Object} between - the roDateTime we want to check
            ' @param {Object} endDateTime - when the range ends
            ' @return {Boolean} true if the roDateTime between is between the other two.
            isBetween: function(startDateTime as Object, between as Object, endDateTime as Object) as Boolean
                return m.compare(between, startDateTime) > 0 and m.compare(between, endDateTime) < 0
            end function,

            ' Compares two dates to know if is before current
            ' @param {Object} current - when the range starts
            ' @param {Object} before - the roDateTime we want to check
            ' @return {Boolean} true if the roDateTime between is before
            isBefore: function(current as Object, before as Object) as Boolean
                return m.compare(current, before) < 0
            end function,

            ' Compares two dates to know if is after current
            ' @param {Object} current - when the range starts
            ' @param {Object} after - the roDateTime we want to check
            ' @returns {Boolean} true if the roDateTime between is after
            isAfter: function(current as Object, after as Object) as Boolean
                return m.compare(current, after) > 0
            end function,

            ' Creates a roDateTime object from a given set of integers
            ' @param {Integer} year - the year
            ' @param {Integer} month - the month
            ' @param {Integer} day - the day of month
            ' @param {Integer} [hour = 0] - the hour
            ' @param {Integer} [minutes = 0] - the minutes
            ' @returns {roDateTime} of the given values
            dateOf: function(year as Integer, month as Integer, day as Integer, hour = 0 as Integer, minutes = 0 as Integer) as Object
                dstr = "{0}-{1}-{2}"
                k = buStringUtils().intToString(month, true)
                d = buStringUtils().intToString(day, true)
                dstr = buStringUtils().substitute(dstr, year, k, d)

                h = buStringUtils().intToString(hour, true)
                k = buStringUtils().intToString(minutes, true)

                tstr = "{0}:{1}:00"
                tstr = buStringUtils().substitute(tstr, h, k, s)

                _date = createObject("roDateTime")
                _date.fromISO8601String(dstr + " " + tstr)
                return _date
            end function,

            ' Parse a String to a roDateTime using a formatter
            ' @param {String} date - String like 2016/11/03 22:30 (depends on formatter)
            ' @param {Object} [formatter = buISODateTimeFormatter] - formatter to use for parsing
            ' @returns {buOptional} the date parsed
            parse: function(date as String, formatter = buISODateTimeFormatter() as Object) as Object
                if buStringUtils().isEmpty(date) then
                    return buOptional().error("date can't be empty")
                end if

                return buOptional(formatter.parse(date))
            end function,

            ' For a given roDateTime transform it to YYYYMMDD 23:59:0000
            ' @param {roDateTime} date - date to convert
            ' @returns {roDateTime} date with the time set to 23:59:0000
            toMidnight: function(date as Object) as Object
                y = date.getYear()
                m = date.getMonth()
                d = date.getDayOfMonth()
                return buDateTimeUtils().dateOf(y, m, d, 23, 59)
            end function,

            ' Calculate time duration in seconds
            ' @param {Object} starts - when the duration starts
            ' @param {Object} ends - when the duration ends
            ' @returns {Integer} seconds between the two dates
            duration: function(starts as Object, ends as Object) as Integer
                if starts = Invalid or ends = Invalid then
                    return 0
                end if

                startSeconds = starts.asSeconds()
                endSeconds = ends.asSeconds()

                return endSeconds - startSeconds
            end function,

            ' Add days to a roDateTime
            ' @param {Object} date - the date to modify
            ' @param {Integer} days - days to add
            ' @returns {roDateTime} the new date
            addDays: function(date as Object, days as Integer) as Object
                if days <= 0 then
                    return date
                end if

                return m.addHours(date, (days * 24))
            end function,

            ' Remove days from a roDateTime
            ' @param {Object} date - the date to modify
            ' @param {Integer} days - days to substract
            ' @returns {roDateTime} the new date
            substractDays: function(date as Object, days as Integer) as Object
                if days <= 0 then
                    return date
                end if

                return m.substractHours(date, (days * 24))
            end function,

            ' Add hours to a roDateTime
            ' @param {Object} date - the date to modify
            ' @param {Integer} hours - hours to add
            ' @returns {roDateTime} the new date
            addHours: function(date as Object, hours as Integer) as Object
                if hours <= 0 then
                    return date
                end if

                seconds = hours * 60 * 60
                newDate = createObject("roDateTime")
                newDate.fromSeconds(date.asSeconds() + seconds)
                return newDate
            end function,

            ' Remove hours from a roDateTime
            ' @param {Object} date - the date to modify
            ' @param {Integer} hours - hours to substract
            ' @returns {roDateTime} the new date
            substractHours: function(date as Object, hours as Integer) as Object
                if hours <= 0 then
                    return date
                end if

                seconds = hours * 60 * 60
                newDate = createObject("roDateTime")
                newDate.fromSeconds(date.asSeconds() - seconds)
                return newDate
            end function,

            ' Converts a roDateTime to a string using a formatter
            ' @param {Object} date - the roDateTime to convert
            ' @param {Object} [formatter = buISODateTimeFormatter] - formatter to use for generating the string
            ' @returns {String} the string in the formatter way
            toString: function(date as Object, formatter = buISODateTimeFormatter() as Object) as String
                if not buTypeUtils().isDateTime(date) then
                    return ""
                end if

                return formatter.toString(date)
            end function,
        }
    endif
    return m.buDateTimeUtils
end function

' roDateTime formatter used by buDateTimeUtils().parse() and buDateTimeUtils().toString() for ISO 8601 date times
' @returns {Object} the date formatter
function buISODateTimeFormatter() as Object
    return {
        parse: function(s as String) as Dynamic
            date = createObject("roDateTime")
            date.fromISO8601String(s)
            return date
        end function,

        toString: function(date as Object) as String
            return date.toISOString()
        end function,
    }
end function

' Generic roDateTime formatter used by buDateTimeUtils().parse() and buDateTimeUtils().toString() for
' dates like YYYY{ds}MM{ds}DD{dts}HH:MM:SS
' @param {String} [ds = "/"] - the date separator
' @param {String} [dts = " "] - the date time separator
' @returns {Object} the date formatter
function buGenericDateTimeFormatter(ds = "/" as String, dts = " " as String) as Object
    return {
        dateSeparator: ds,
        dateTimeSeparator: dts,

        parse: function(str as String) as Object
            arr1 = str.tokenize(m.dateTimeSeparator)

            if arr1.count() <> 2 then
                return Invalid
            end if

            dateTokens = arr1[0].tokenize(m.dateSeparator)

            if dateTokens.count() <> 3 then
                return Invalid
            end if

            ' Now, roDateTime only likes ISO format YYYY-MM-DD HH:MM:SS
            res = createObject("roDateTime")
            res.fromISO8601String(dateTokens[0] + "-" + dateTokens[1] + "-" + dateTokens[2] + " " + arr1[1])
            return res
        end function,

        toString: function(date as Object) as String
            dstr = "{0}" + m.dateSeparator + "{1}" + m.dateSeparator + "{2}"
            k = buStringUtils().intToString(date.getMonth(), true)
            d = buStringUtils().intToString(date.getDayOfMonth(), true)
            dstr = buStringUtils().substitute(dstr, date.getYear(), k, d)

            h = buStringUtils().intToString(date.getHours(), true)
            k = buStringUtils().intToString(date.getMinutes(), true)
            s = buStringUtils().intToString(date.getSeconds(), true)

            tstr = "{0}:{1}:{2}"
            tstr = buStringUtils().substitute(tstr, h, k, s)
            return dstr + m.dateTimeSeparator + tstr
        end function,
    }
end function
