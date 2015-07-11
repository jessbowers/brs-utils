'
' Utils to different inputs
'
' @singleton
' @returns {Object} the buValidationUtils singleton
' @license MIT
' @functions
' * isEmail
' * isURL
' * isCreditCard
' * lunhCheck
function buValidationUtils() as Object
    if(m.buValidationUtils = Invalid) then
        m.buValidationUtils = {

            ' Using a simple regular expression checks for a valid email address
            isEmail: function(email as String) as Boolean
                roRegex = createObject("roRegex", "[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}", "i")
                return roRegex.isMatch(email)
            end function,

            ' Using a simple regular expression checks for a valid http/s URL
            isURL: function(url as String) as Boolean
                roRegex = createObject("roRegex", "(https?://([-\w\.]+)+(:\d+)?(/([\w/_\.]*(\?\S+)?)?)?)", "i")
                return roRegex.isMatch(url)
            end function,

            ' Checks for valid credit cards. This includes a preliminary check of some common attributes
            ' and later it checks for: visa, mastercard, discover, diners and amex
            ' @param {String} cc - the credit card as 1234123412341234 (numbers only)
            ' @param {roArray} [validators = Invalid] - the validators to use. By default it uses all validators. If
            ' given an empty roArray it will perform a preliminary check only
            ' @return {Boolean} true if a valid card
            isCreditCard: function(cc as String, validators = Invalid as Dynamic) as Boolean
                if (not buStringUtils().isNumeric(cc)) or len(cc) < 13 or len(cc) > 19 then
                    return false
                end if

                if not m.lunhCheck(cc) then
                    return false
                end if

                if validators <> Invalid and validators.count() = 0 then
                    ' we're done checking
                    return true
                end if

                if validators = Invalid then
                    validators = [m.isVisa, m.isMasterCard, m.isDiscover, m.isAMEX, m.isDinersClub]
                end if

                for each validator in validators
                    if validator(cc) then
                        return true
                    end if
                end for

                return false
            end function,

            lunhCheck: function(cc as String) as Boolean
                cc = buStringUtils().reverse(cc)
                s1 = 0
                s2 = 0
                for i = 1 to len(cc) step +1
                    if i mod 2 > 0 then
                        s1 = s1 + val(mid(cc,i,1))
                    else
                        tmp = val(mid(cc,i,1))*2
                        if  tmp < 10 then
                            s2 = s2 + tmp
                        else
                            s2 = s2 + val(right(str(tmp),1)) + 1
                        end if
                    end if
                end for
                return right(str(s1 + s2),1) = "0"
            end function,

            isVisa: function(cc as String) as Boolean
                return len(cc) = 13 or len(cc) = 16 and left(cc, 1) = "4"
            end function,

            isAMEX: function(cc as String) as Boolean
                prefixes = ["34", "37"]
                return len(cc) = 15 and buArrayUtils().contains(prefixes, left(cc, 2))
            end function,

            isMasterCard: function(cc as String) as Boolean
                prefixes = ["51","52","53","54","55"]
                return len(cc) = 16 and buArrayUtils().contains(prefixes, left(cc, 2))
            end function,

            isDiscover: function(cc as String) as Boolean
                return len(cc) = 16 and left(cc, 4) = "6011"
            end function,

            isDinersClub: function(cc as String) as Boolean
                prefixes = ["300","301","302","303","305"]
                return len(cc) = 14 and buArrayUtils().contains(prefixes, left(cc, 3))
            end function,
        }
    end if
    return m.buValidationUtils
end function
