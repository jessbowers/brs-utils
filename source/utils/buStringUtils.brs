'
' Set of utils to work and transform Strings
'
' @singleton
' @returns {Object} the buStringUtils singleton
' @license MIT
' @functions
' * isEmpty
' * intToString
' * doubleToString
' * floatToString
' * arrayToString
' * objectToString
' * toStr
' * equals
' * truncate
' * capitalize
' * split
' * contains
' * indexOf
' * lastIndexOf
' * join
' * toArray
' * reverse
' * replace
' * toMD5Hash
' * toSHA1Hash
' * toSHA256Hash
' * toSHA512Hash
' * substitute
' * toString
' * isNumeric
function buStringUtils() as Object
    if(m.buStringUtils = Invalid) then
        m.buStringUtils = {
            '
            ' Checks if a string is empty:
            ' @param {String} text - The string to check
            ' @returns {Boolean} true if the string is "" or " "
            '
            isEmpty: function(text as String) as Boolean
                return len(text.trim()) = 0
            end function,

            ' Convert int to string. This is necessary because the builtin Stri(x) prepends whitespace
            ' @param {Integer} i - the integer to convert
            ' @param {Boolean} [prependZero = false] - Indicates to add 0 to values less than 10
            ' @returns {String} the string value of the integer
            intToString: function(i As Integer, prependZero = false as Boolean) As String
                s = Stri(i)
                s = s.trim()

                if(prependZero and i >= 0 and i < 10) then
                    s = "0" + s
                end if

                return s
            end function,

            ' Convert double to string. This is necessary because the builtin Stri(x) prepends whitespace
            ' @param {Double} x - the Double to convert
            ' @returns {String} the string value of the Double
            doubleToString: function(x# as Double) as String
               s = Str(x#)
               return s.trim()
            end function,

            ' Convert Float to string. This is necessary because the builtin Stri(x) prepends whitespace
            ' @param {Float} x - the Float to convert
            ' @returns {String} the string value of the Float
            floatToString: function(x! as Float) as String
               s = Str(x!)
               return s.trim()
            end function,

            arrayToString: function(arr as Object) as String
                if not buTypeUtils().isArray(arr) then
                    return m.toString(arr)
                end if

                res = []
                for each el in arr
                    if buTypeUtils().isArray(el) then
                        res.push(m.arrayToString(el))
                    else
                        res.push(m.toString(el))
                    end if
                end for

                return "[" + m.join(res, ",") + "]"
            end function,

            objectToString: function(obj as Object) as String
                if not buTypeUtils().isObject(obj) then
                    return m.toString(obj)
                end if

                res = []

                for each k in obj
                    el = obj[k]

                    str = k + ":"
                    if buTypeUtils().isObject(el) then
                        str = str + m.objectToString(el)
                    else if buTypeUtils().isArray(el) then
                        str = str + m.arrayToString(el)
                    else
                        str = str + m.toString(el)
                    end if

                    res.push(str)
                end for
                return "{" + m.join(res, ",") + "}"
            end function,

            ' Converts anything to a string
            ' @param {Dynamic} the value to convert to a string.
            ' @returns {String} the converted string. Defaults to "NaS"
            '
            toStr: function(any as Dynamic) as String
                ret = m.toString(any)
                if ret = Invalid ret = type(any)
                if ret = Invalid ret = "NaS"
                return ret
            end function,

            ' Invalid safe string comparison
            ' @param {String} str1 the first string
            ' @param {String} str2 the second string
            ' @returns {Boolean} true if both params are the same
            equals: function(str1 as Dynamic, str2 as Dynamic) as Boolean
                return m.toString(str1) = m.toString(str2)
            end function

            ' Truncates a string to the given length and appends the ellipsis
            ' @param {String} text: the text to truncate
            ' @param {Integer} length the maximum allowed length for the string
            ' @param {String} [ellipsis] the text to use as ellipsis. Defaults to ...
            ' @returns {String} the truncated string
            truncate: function(text as String, length as Integer, ellipsis = "..." as String) as String
                truncated = ""
                if text.len() > length then
                    truncated = left(text, length) + ellipsis
                else
                    truncated = text
                end if
                return truncated
            end function,

            ' Capitalize a string so the only uppercase letter is the first one
            ' @param {String} the text to capitalize
            ' @returns {String} text capitalized
            capitalize: function(text as String) as String
                if text.len() > 1 then
                   first = text.left(1)
                   rest = text.mid(1)
                   return uCase(first) + lCase(rest)
                end if
                return text
            end function,

            ' Converts a string to a roList
            split: function(text as String, delim as String) as Object
                regex = createObject("roRegex", delim, "")
                return regex.split(text)
            end function,

            ' Searchs for the matching pattern (regex) and in text.
            contains: function(text as String, regex as String) as Boolean
                roRegex = createObject("roRegex", regex, "")
                return roRegex.isMatch(text)
            end function,

            ' Finds the first index within a String
            ' @param text the String to check, may be null
            ' @param ch the character to find
            ' @return the first index of the search character or -1 if no match
            indexOf: function(text as String, ch as String) as Integer
                roRegex = createObject("roRegex", ch, "")

                if(not roRegex.isMatch(text)) then
                    return -1
                end if

                res = roRegex.split(text)
                return len(res[0])
            end function,

            ' Finds the last index within a String
            ' @param text  the String to check
            ' @param ch  the character to find
            ' @return the last index of the search character or -1 if no match
            lastIndexOf: function(text as String, ch as String) as Integer
                roRegex = createObject("roRegex", ch, "")

                if(not roRegex.isMatch(text)) then
                    return -1
                end if

                res = roRegex.split(text)
                sum = 0

                for i = 0 to (res.count() - 2) step +1
                    sum = sum + len(res[i]) + 1
                end for
                return sum
            end function,

            ' Joins an array of different elements to a single string. Calls toString on each
            ' element of the array so object types will be printed by default: "Lorem Ipsum roRegex"
            ' @param arr the array to join
            ' @param delimeter the delimeter to append to each element
            ' @return a String of all elements on the array
            join: function(arr as Dynamic, delimeter = "" as String) as String
                if(not buTypeUtils().isArray(arr)) then
                    return ""
                end if

                result = ""
                for i = 0 to arr.count() - 1 step +1
                    el = arr[i]
                    if(i = 0) then
                        result = m.toString(el)
                    else
                        result = result + delimeter + m.toString(el)
                    end if
                end for

                return result
            end function,

            ' Converts a String to a roArray. Because BrightScript doesn't support the char type
            ' @param text the String to split
            ' @return a roArray with each character of the string
            toArray: function(text as String) as Object
                arr = []
                if(m.isEmpty(text)) then
                    return arr
                end if

                for i = 0 to len(text) - 1 step +1
                    arr.push(text.mid(i, 1))
                end for

                return arr
            end function,

            ' Reverse a string Lorem to meroL
            reverse: function(text as String) as String
                if(m.isEmpty(text)) then
                    return text
                end if

                reversed = []
                arr = m.toArray(text)

                for i = arr.count() - 1 to 0 step -1
                    reversed.push(arr[i])
                end for

                return m.join(reversed)
            end function,

            replace: function(text as String, pattern as String, replacement as String) as String
                roRegex = createObject("roRegex", pattern, "")
                return roRegex.replace(text, replacement)
            end function,

            toMD5Hash: function(text as String) as String
                return m._hash(text, "md5")
            end function,

            toSHA1Hash: function(text as String) as String
                return m._hash(text, "sha1")
            end function,

            toSHA256Hash: function(text as String) as String
                return m._hash(text, "sha256")
            end function,

            toSHA512Hash: function(text as String) as String
                return m._hash(text, "sha512")
            end function,

            _hash: function(text as Object, algorithm = "md5" as String) as String
                ba = createObject("roByteArray")
                ba.fromASCIIString(text)
                digest = createObject("roEVPDigest")
                digest.setup(algorithm)
                return digest.process(ba)
            end function,

            ' Like the native substitute but accepts any value and not only strings
            ' @param {String} str - the string with the format.
            ' @param {Dynamic} a - the first value to susbtitute.
            ' @param {Dynamic} b - the second value to susbtitute.
            ' @param {Dynamic} c - the third value to susbtitute.
            ' @returns {String} the converted string
            substitute: function(str as String, a = Invalid as Dynamic, b = Invalid as Dynamic, c = Invalid as Dynamic) as String
                return substitute(str, m.toString(a), m.toString(b), m.toString(c))
            end function,

            ' Converts anything to a string, even an Invalid value.
            ' @param {Dynamic} the value to convert to a string.
            ' @returns {String} the converted string or the type if we can't convert
            toString: function(any as Dynamic) as String
                if buTypeUtils().isUnitialized(any) return "Uninitilized"
                if any = Invalid return "Invalid"
                if buTypeUtils().isString(any) return any
                if buTypeUtils().isInt(any) return m.intToString(any)
                if buTypeUtils().isBool(any)
                    if any return "true"
                    return "false"
                endif
                if buTypeUtils().isFloat(any) then return m.floatToString(any)
                if buTypeUtils().isDouble(any) then return m.doubleToString(any)
                if buTypeUtils().isArray(any) then return m.arrayToString(any)
                if buTypeUtils().isObject(any) then return m.objectToString(any)
                if buTypeUtils().isDateTime(any) then return any.toISOString()
                return type(any)
            end function,

            isNumeric: function(text as String) as Boolean
                if m.isEmpty(text) then return false

                roRegex = createObject("roRegex", "^[0-9]*$", "")
                return roRegex.isMatch(text)
            end function
        }
    endif

    return m.buStringUtils
end function
