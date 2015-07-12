function buSetTests() as Object
    tests = {
        testGet: function() as Void
            s = buSet([1,2,3])
            buTest().assertEquals(s.get(0), 1)
            buTest().assertInvalid(s.get(10))
        end function,

        testContains: function() as Void
            s = buSet([1,2,3])
            buTest().assertTrue(s.contains(1))
            buTest().assertFalse(s.contains(0))
        end function,

        testAdd: function() as Void
            s = buSet([1,2,3])
            buTest().assertTrue(s.add(10))
            buTest().assertFalse(s.add(1))
        end function,

        testRemove: function() as Void
            s = buSet([1,2,3])
            buTest().assertTrue(s.remove(1))
            buTest().assertEquals(s.count(), 2)
            buTest().assertFalse(s.remove(10))
            buTest().assertEquals(s.count(), 2)
        end function,

        testEquals: function() as Void
            buTest().assertTrue(buSet([1,2,3]).equals(buSet([1,2,3])))
            buTest().assertTrue(buSet([1,2,3]).equals(buSet([1,2,3,3])))
            buTest().assertTrue(buSet(["1","2","3"]).equals(buSet(["1","2","3"])))
            buTest().assertTrue(buSet().equals(buSet()))
            buTest().assertFalse(buSet([1,2,3]).equals(buSet([1,2,3,4])))
        end function,

        testFilter: function() as Void
            expected = buSet([1,3,5,7,9])
            s = buSet([1,2,3,4,5,6,7,8,9,9])
            res = s.filter(function(i, el) as Boolean
                return buNumbersUtils().isOdd(el)
            end function)
            buTest().assertTrue(res.equals(expected), "failed to filter set by odd numbers")
        end function

        testEach: function() as Void
            expected = buSet([1,3,5,7,9,11,13,15,17])
            s = buSet([1,2,3,4,5,6,7,8,9,9])
            res = s.each(function(i, el) as Dynamic
                return i + el
            end function)
            buTest().assertTrue(res.equals(expected), "failed to apply to each element")
        end function

        testFilterEach: function() as Void
            expected = buSet([1,4,7,10,13])

            s = buSet([1,2,3,4,5,6,7,8,9,9])
            res = s.filter(function(i, el) as Boolean
                return buNumbersUtils().isOdd(el)
            end function).each(function(i, el) as Dynamic
                return i + el
            end function)

            buTest().assertTrue(res.equals(expected))
        end function

        addSuite: function() as Void
            suite = {
                name: "buSetTests",
                tests: [
                    { name: "testGet", test: m.testGet },
                    { name: "testContains", test: m.testContains },
                    { name: "testAdd", test: m.testAdd },
                    { name: "testRemove", test: m.testRemove },
                    { name: "testEquals", test: m.testEquals },
                    { name: "testFilter", test: m.testFilter },
                    { name: "testEach", test: m.testEach },
                    { name: "testFilterEach", test: m.testFilterEach },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
