'
' Set of utils to work on and transform numbers (Integer, Float & Double)
' @singleton
' @returns {Object} the buNumbersUtils singleton
' @license MIT
' @functions
' * max
' * min
' * floor
' * ceiling
' * round
' * isOdd
' * isEven
' * bin2dec
' * hex2dec
' * rad2deg
' * deg2rad
' * factorial
' * average
function buNumbersUtils() as Object
    if(m.buNumbersUtils = Invalid) then
        m.buNumbersUtils = {

            PI: 3.14159265!,

            ' From a list of numbers, returns the maximum one. The values of the list
            ' have to be consistent: all integers or all floats
            ' @param {roArray} arr - the array with the values
            ' @returns {Dynamic} the maximum value from the array
            max: function(arr as Dynamic) as Dynamic
                max = arr[0]

                if(buTypeUtils().isNumber(max) = false) then
                    return Invalid
                end if

                if(buArrayUtils().isEmpty(arr)) then
                    return Invalid
                end if

                for each el in arr
                    if(el > max) then
                        max = el
                    end if
                end for

                return max
            end function,

            ' From a list of numbers, returns the minimum one. The values of the list
            ' have to be consistent: all integers or all floats
            ' @param {roArray} arr - the array with the values
            ' @returns {Dynamic} the minimum value from the array
            min: function(arr as Dynamic) as Dynamic
                min = arr[0]

                if(buTypeUtils().isNumber(min) = false) then
                    return Invalid
                end if

                if(buArrayUtils().isEmpty(arr)) then
                    return Invalid
                end if

                for each el in arr
                    if(el < min) then
                        min = el
                    end if
                end for

                return min
            end function,

            ' Get the smallest integer not less than value. For example, for 3.1 returns 4
            ' @param {Dynamic} value - the float or double value
            ' @returns {Integer} the smallest integer not less than value.
            ceiling: function(value as Dynamic) as Integer
                if(buTypeUtils().isNumber(value) = false) then
                    return 0
                end if

                if value - int(value) > 0 then
                    return int(value) + 1
                else
                    return int(value)
                end if
            end function,

            ' Get largest integer not greater than  value. For example, for 3.1 returns 3
            ' @param {Dynamic} value - the float or double value
            ' @returns {Integer} the largest integer not greater than value.
            floor: function(value as Dynamic) as Integer
                if(buTypeUtils().isNumber(value) = false) then
                    return 0
                end if

                return int(value)
            end function,

            ' Rounds a number up or down to the nearest integer
            ' @param {Dynamic} value - the float or double value
            ' @returns {Integer} the nearest integer
            round: function(value as Dynamic) as Integer
                if(buTypeUtils().isNumber(value) = false) then
                    return 0
                end if

                if value - int(value) >= 0.5 then
                    return int(value) + 1
                else
                    return int(value)
                end if
            end function,

            ' Checks whether the provided value is odd.
            ' @param {Dynamic} value - the number to check
            ' @returns {Boolean} true if the number is odd
            isOdd: function(value as Dynamic) as Boolean
                if(buTypeUtils().isNumber(value) = false) then
                    return false
                end if

                if value < 0 then value = value * (-1)

                return (m.floor(value) mod 2) <> 0
            end function,

            ' Checks whether the provided value is even.
            ' @param {Dynamic} value - the number to check
            ' @returns {Boolean} true if the number is even
            isEven: function(value as Dynamic) as Boolean
                if(buTypeUtils().isNumber(value) = false) then
                    return false
                end if

                if value < 0 then value = value * (-1)

                return (m.floor(value) mod 2) = 0
            end function,

            ' Converts a signed binary number to decimal format
            bin2dec: function(binary as String) as Integer
                return val(binary, 2)
            end function,

            ' Converts a signed hexadecimal number to decimal format
            hex2dec: function(hex as String) as Integer
                return val(hex, 16)
            end function,

            ' Converts an angle value in radians to degrees.
            rad2deg: function(radian as Float) as Float
                return radian * (180 / m.PI)
            end function,

            ' Converts an angle value in degrees to radians.
            deg2rad: function(degrees as Float) as Float
                return degrees * (m.PI / 180)
            end function,

            ' Calculates the factorial of a number.
            factorial: function(value as Integer) as Float
                if value = 0 then return 1
                if value < 0 then return -1
                return value * m.factorial(value - 1)
            end function,

            ' Calculates the numerical average value in a list.
            ' @params {roArray} arr - the array of values
            ' @returns the numerical average value in a list of numbers
            average: function(arr as Object) as Float
                if arr.count() = 0 then return 0

                sum = 0
                for each v in arr
                    sum = sum + v
                end for

                return sum / arr.count()
            end function,
        }
    end if

    return m.buNumbersUtils
end function
