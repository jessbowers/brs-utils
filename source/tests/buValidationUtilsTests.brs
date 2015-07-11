function buValidationUtilsTests() as Object
    tests = {
        testIsEmail: function() as Void
            buTest().assertTrue(buValidationUtils().isEmail("foo@example.com"))
            buTest().assertFalse(buValidationUtils().isEmail("example.com"))
            buTest().assertFalse(buValidationUtils().isEmail(""))
            buTest().assertFalse(buValidationUtils().isEmail(" "))
        end function,

        testIsUrl: function() as Void
            buTest().assertTrue(buValidationUtils().isURL("http://example.com"))
        end function,

        testLunhCheck: function() as Void
            buTest().assertFalse(buValidationUtils().lunhCheck("49927398717"))
            buTest().assertFalse(buValidationUtils().lunhCheck("1234567812345678"))
            buTest().assertTrue(buValidationUtils().lunhCheck("49927398716"))
            buTest().assertTrue(buValidationUtils().lunhCheck("1234567812345670"))
        end function,

        testIsCreditCard: function() as Void
            buTest().assertFalse(buValidationUtils().isCreditCard(""))
            buTest().assertFalse(buValidationUtils().isCreditCard("123456789012"))
            buTest().assertFalse(buValidationUtils().isCreditCard("12345678901234567890"))
            buTest().assertFalse(buValidationUtils().isCreditCard("4417123456789112"))
            buTest().assertFalse(buValidationUtils().isCreditCard("4417q23456w89113"))

            VALID_VISA_1 = "4417123456789113"
            VALID_VISA_2 = "4222222222222"
            VALID_AMEX = "378282246310005"
            VALID_MC = "5105105105105100"
            VALID_DISCOVER = "6011000990139424"
            VALID_DINERS = "30569309025904"

            buTest().assertTrue(buValidationUtils().isCreditCard(VALID_VISA_1))
            buTest().assertTrue(buValidationUtils().isCreditCard(VALID_VISA_2))
            buTest().assertTrue(buValidationUtils().isCreditCard(VALID_AMEX))
            buTest().assertTrue(buValidationUtils().isCreditCard(VALID_MC))
            buTest().assertTrue(buValidationUtils().isCreditCard(VALID_DISCOVER))
            buTest().assertTrue(buValidationUtils().isCreditCard(VALID_DINERS))

            ' Check only for visa
            buTest().assertTrue(buValidationUtils().isCreditCard(VALID_VISA_1, [buValidationUtils().isVisa]))
            buTest().assertFalse(buValidationUtils().isCreditCard(VALID_AMEX, [buValidationUtils().isVisa]))

            ' Check that the CC is valid but not for any specific company
            buTest().assertTrue(buValidationUtils().isCreditCard(VALID_VISA_1, []))
        end function,

        addSuite: function() as Void
            suite = {
                name: "buValidationUtilsTests",
                tests: [
                    { name: "testIsEmail", test: m.testIsEmail },
                    { name: "testIsUrl", test: m.testIsUrl },
                    { name: "testLunhCheck", test: m.testLunhCheck },
                    { name: "testIsCreditCard", test: m.testIsCreditCard },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
