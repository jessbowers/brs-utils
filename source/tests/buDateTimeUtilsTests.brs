function buDateTimeUtilsTests() as Object
    tests = {
        testParse: function() as Void
            buTest().assertTrue(buDateTimeUtils().parse("2015-07-10T22:07:24Z").isPresent())
            buTest().assertFalse(buDateTimeUtils().parse("").isPresent())

            formatter = buGenericDateTimeFormatter("-", "T")
            buTest().assertTrue(buDateTimeUtils().parse("2015-07-10T22:07:24Z", formatter).isPresent())

            formatter = buGenericDateTimeFormatter()
            buTest().assertTrue(buDateTimeUtils().parse("2015/07/10 22:07:24Z", formatter).isPresent())
            buTest().assertTrue(buDateTimeUtils().parse("2015/07/10 22:07:24", formatter).isPresent())
        end function,

        testDateOf: function() as Void
            d = buDateTimeUtils().dateOf(2014, 10, 29, 0, 30)
            buTest().assertEquals(d.getYear(), 2014)
            buTest().assertEquals(d.getMonth(), 10)
            buTest().assertEquals(d.getDayOfMonth(), 29)
            buTest().assertEquals(d.getHours(), 0)
            buTest().assertEquals(d.getMinutes(), 30)

            d = buDateTimeUtils().dateOf(2014, 10, 29)
            buTest().assertEquals(d.getYear(), 2014)
            buTest().assertEquals(d.getMonth(), 10)
            buTest().assertEquals(d.getDayOfMonth(), 29)
            buTest().assertEquals(d.getHours(), 0)
            buTest().assertEquals(d.getMinutes(), 0)
        end function,

        testCompare: function() as Void
            d1 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            d2 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            buTest().assert(buDateTimeUtils().compare(d1, d2) = 0, "Failed to compare equal dates")

            d1 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            d2 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 31)
            buTest().assert(buDateTimeUtils().compare(d1, d2) < 0, "Failed to compare < dates")

            d1 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 32)
            d2 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 31)
            buTest().assert(buDateTimeUtils().compare(d1, d2) > 0, "Failed to compare > dates")
        end function,

        testIsBetween: function() as Void
            dates = [
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 30),
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 31), ' is between
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 32)
            ]

            buTest().assertTrue(buDateTimeUtils().isBetween(dates[0], dates[1], dates[2]))

            dates = [
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 30),
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 29), ' is before
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 32)
            ]

            buTest().assertFalse(buDateTimeUtils().isBetween(dates[0], dates[1], dates[2]))

            dates = [
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 30),
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 33), ' is after
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 32)
            ]
            buTest().assertFalse(buDateTimeUtils().isBetween(dates[0], dates[1], dates[2]))
        end function,

        testIsBefore: function() as Void
            dates = [
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 30),
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 31)
            ]
            buTest().assertTrue(buDateTimeUtils().isBefore(dates[0], dates[1]))
            buTest().assertFalse(buDateTimeUtils().isBefore(dates[1], dates[0]))
        end function,

        testIsAfter: function() as Void
            dates = [
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 30),
                buDateTimeUtils().dateOf(2014, 10, 29, 10, 31)
            ]
            buTest().assertTrue(buDateTimeUtils().isAfter(dates[1], dates[0]))
            buTest().assertFalse(buDateTimeUtils().isAfter(dates[0], dates[1]))
        end function,

        testToMidnight: function() as Void
            d = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            expected = buDateTimeUtils().dateOf(2014, 10, 29, 23, 59)
            buTest().assertEquals(buDateTimeUtils().compare(buDateTimeUtils().toMidnight(d), expected), 0)
        end function,

        testDuration: function() as Void
            a = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            b = buDateTimeUtils().dateOf(2014, 10, 29, 23, 59)
            buTest().assertEquals(buDateTimeUtils().duration(a, b), 48540)
        end function,

        testAddHours: function() as Void
            d1 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            d2 = buDateTimeUtils().dateOf(2014, 10, 29, 11, 30)
            d3 = buDateTimeUtils().dateOf(2014, 10, 29, 12, 30)
            buTest().assertEquals(buDateTimeUtils().compare(buDateTimeUtils().addHours(d1, 1), d2), 0)
            buTest().assertEquals(buDateTimeUtils().compare(buDateTimeUtils().addHours(d1, 2), d3), 0)
        end function,

        testAddDays: function() as Void
            d1 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            d2 = buDateTimeUtils().dateOf(2014, 10, 30, 10, 30)
            d3 = buDateTimeUtils().dateOf(2014, 10, 31, 10, 30)

            buTest().assertEquals(buDateTimeUtils().compare(buDateTimeUtils().addDays(d1, 1), d2), 0)
            buTest().assertEquals(buDateTimeUtils().compare(buDateTimeUtils().addDays(d1, 2), d3), 0)
        end function,

        testSubstractHours: function() as Void
            d1 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            d2 = buDateTimeUtils().dateOf(2014, 10, 29, 9, 30)
            d3 = buDateTimeUtils().dateOf(2014, 10, 29, 8, 30)

            buTest().assertEquals(buDateTimeUtils().compare(buDateTimeUtils().substractHours(d1, 1), d2), 0)
            buTest().assertEquals(buDateTimeUtils().compare(buDateTimeUtils().substractHours(d1, 2), d3), 0)
        end function,

        testSubstractDays: function() as Void
            d1 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            d2 = buDateTimeUtils().dateOf(2014, 10, 28, 10, 30)
            d3 = buDateTimeUtils().dateOf(2014, 10, 27, 10, 30)

            buTest().assertEquals(buDateTimeUtils().compare(buDateTimeUtils().substractDays(d1, 1), d2), 0)
            buTest().assertEquals(buDateTimeUtils().compare(buDateTimeUtils().substractDays(d1, 2), d3), 0)
        end function,

        testToString: function() as Void
            d1 = buDateTimeUtils().dateOf(2014, 10, 29, 10, 30)
            buTest().assertEquals(buDateTimeUtils().toString(d1), "2014-10-29T10:30:00Z")

            formatter = buGenericDateTimeFormatter("-", "T")
            buTest().assertEquals(buDateTimeUtils().toString(d1, formatter), "2014-10-10T10:30:00")

            formatter = buGenericDateTimeFormatter()
            buTest().assertEquals(buDateTimeUtils().toString(d1, formatter), "2014/10/10 10:30:00")
        end function,

        addSuite: function() as Void
            suite = {
                name: "buDateTimeUtilsTests",
                tests: [
                    { name: "testParse", test: m.testParse },
                    { name: "testDateOf", test: m.testDateOf },
                    { name: "testCompare", test: m.testCompare },
                    { name: "testIsBetween", test: m.testIsBetween },
                    { name: "testIsBefore", test: m.testIsBefore },
                    { name: "testIsAfter", test: m.testIsAfter },
                    { name: "testToMidnight", test: m.testToMidnight },
                    { name: "testDuration", test: m.testDuration },
                    { name: "testAddHours", test: m.testAddHours },
                    { name: "testAddDays", test: m.testAddDays },
                    { name: "testSubstractHours", test: m.testSubstractHours },
                    { name: "testSubstractDays", test: m.testSubstractDays },
                    { name: "testToString", test: m.testToString }
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
