function buListTests() as Object
    tests = {
        testGet: function() as Void
            s = buList([1,2,3])
            buTest().assertEquals(s.get(0), 1)
            buTest().assertInvalid(s.get(10))
        end function,

        testAdd: function() as Void
            expected = buList([1,2,3])
            list = buList()
            list.add(1).add(2).add(3)
            buTest().assertTrue(list.equals(expected))
        end function,

        testIsEmpty: function() as Void
            buTest().assertTrue(buList([]).isEmpty())
            buTest().assertFalse(buList([1,2,3]).isEmpty())
        end function,

        testIndexOf: function() as Void
            buTest().assertEquals(buList([1,2,3]).indexOf(4), -1)
            buTest().assertEquals(buList([1,2,3]).indexOf(2), 1)
        end function,

        testContains: function() as Void
            s = buList([1,2,3])
            buTest().assertTrue(s.contains(1))
            buTest().assertFalse(s.contains(0))
        end function,

        testRemove: function() as Void
            s = buList([1,2,3])
            buTest().assertTrue(s.remove(1))
            buTest().assertEquals(s.count(), 2)
            buTest().assertFalse(s.remove(10))
            buTest().assertEquals(s.count(), 2)
        end function,

        testEquals: function() as Void
            buTest().assertTrue(buList([1,2,3]).equals(buList([1,2,3])))
            buTest().assertTrue(buList([1,2,3,3]).equals(buList([1,2,3,3])))
            buTest().assertTrue(buList(["1","2","3"]).equals(buList(["1","2","3"])))
            buTest().assertTrue(buList().equals(buList()))
            buTest().assertFalse(buList([1,2,3]).equals(buList([1,2,3,4])))
        end function,

        testSubList: function() as Void
            expected = buList([3, 4, 8])
            list = buList([1, 2, 3, 4, 8, 9])
            buTest().assertTrue(list.subList(2, 4).equals(expected), "subList from the middle")
        end function

        testFilter: function() as Void
            expected = buList([1,3,5,7,9,9])
            s = buList([1,2,3,4,5,6,7,8,9,9])
            res = s.filter(function(i, el) as Boolean
                return buNumbersUtils().isOdd(el)
            end function)
            buTest().assertTrue(res.equals(expected), "failed to filter set by odd numbers")
        end function

        testEach: function() as Void
            expected = buList([1,3,5,7,9,11,13,15,17])
            s = buList([1,2,3,4,5,6,7,8,9])
            res = s.each(function(i, el) as Dynamic
                return i + el
            end function)
            buTest().assertTrue(res.equals(expected), "failed to apply to each element")
        end function

        testFilterEach: function() as Void
            expected = buList([1,4,7,10,13])

            s = buList([1,2,3,4,5,6,7,8,9])
            res = s.filter(function(i, el) as Boolean
                return buNumbersUtils().isOdd(el)
            end function).each(function(i, el) as Dynamic
                return i + el
            end function)

            buTest().assertTrue(res.equals(expected))
        end function

        addSuite: function() as Void
            suite = {
                name: "buListTests",
                tests: [
                    { name: "testGet", test: m.testGet },
                    { name: "testAdd", test: m.testAdd },
                    { name: "testIsEmpty", test: m.testIsEmpty },
                    { name: "testIndexOf", test: m.testIndexOf },
                    { name: "testSubList", test: m.testSubList },
                    { name: "testContains", test: m.testContains },
                    { name: "testRemove", test: m.testRemove },
                    { name: "testEquals", test: m.testEquals },
                    { name: "testFilter", test: m.testFilter },
                    { name: "testEach", test: m.testEach },
                    { name: "testFilterEach", test: m.testFilterEach }
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
