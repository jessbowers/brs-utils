function buNumbersUtilsTests() as Object
    tests = {
        testMax: function() as Void
            buTest().assertEquals(buNumbersUtils().max([1,2,4,9,2,5,1]), 9)
            buTest().assertInvalid(buNumbersUtils().max(["1","2"]))
            buTest().assertInvalid(buNumbersUtils().max([]))
        end function,

        testMin: function() as Void
            buTest().assertEquals(buNumbersUtils().min([1,2,-4,9,2,5,1]), -4)
            buTest().assertInvalid(buNumbersUtils().min(["1","2"]))
            buTest().assertInvalid(buNumbersUtils().min([]))
        end function,

        testCeiling: function() as Void
            buTest().assertEquals(buNumbersUtils().ceiling(2.4!), 3)
            buTest().assertEquals(buNumbersUtils().ceiling(2.4#), 3)
            buTest().assertEquals(buNumbersUtils().ceiling(2.9!), 3)
            buTest().assertEquals(buNumbersUtils().ceiling(-2.7!), -2)
            buTest().assertEquals(buNumbersUtils().ceiling(2), 2)
            buTest().assertEquals(buNumbersUtils().ceiling(-2), -2)
            buTest().assertEquals(buNumbersUtils().ceiling("2.1"), 0)
        end function,

        testFloor: function() as Void
            buTest().assertEquals(buNumbersUtils().floor(2.1!), 2)
            buTest().assertEquals(buNumbersUtils().floor(2.1#), 2)
            buTest().assertEquals(buNumbersUtils().floor(2.9!), 2)
            buTest().assertEquals(buNumbersUtils().floor(-2.7!), -3)
            buTest().assertEquals(buNumbersUtils().floor(2), 2)
            buTest().assertEquals(buNumbersUtils().floor(-2), -2)
            buTest().assertEquals(buNumbersUtils().floor("2.1"), 0)
        end function,

        testRound: function() as Void
            buTest().assertEquals(buNumbersUtils().round(2.1!), 2)
            buTest().assertEquals(buNumbersUtils().round(2.5!), 3)
            buTest().assertEquals(buNumbersUtils().round(2.1#), 2)
            buTest().assertEquals(buNumbersUtils().round(2.5#), 3)
            buTest().assertEquals(buNumbersUtils().round(1), 1)
        end function,

        testIsOdd: function() as Void
            buTest().assertTrue(buNumbersUtils().isOdd(1), "1")
            buTest().assertTrue(buNumbersUtils().isOdd(3), "3")
            buTest().assertTrue(buNumbersUtils().isOdd(-1), "-1")
            buTest().assertTrue(buNumbersUtils().isOdd(1.1!), "1.1")
            buTest().assertTrue(buNumbersUtils().isOdd(-1.1!), "-1.1")

            buTest().assertFalse(buNumbersUtils().isOdd(-2.1!), "-2.1")
            buTest().assertFalse(buNumbersUtils().isOdd(2.1!), "2.1")
            buTest().assertFalse(buNumbersUtils().isOdd(2), "2")
            buTest().assertFalse(buNumbersUtils().isOdd(-2), "-2")
            buTest().assertFalse(buNumbersUtils().isOdd(0), "0")
        end function,

        testIsEven: function() as Void
            buTest().assertFalse(buNumbersUtils().isEven(1))
            buTest().assertFalse(buNumbersUtils().isEven(3))
            buTest().assertFalse(buNumbersUtils().isEven(-1))
            buTest().assertFalse(buNumbersUtils().isEven(1.1!))
            buTest().assertFalse(buNumbersUtils().isEven(-1.1!))

            buTest().assertTrue(buNumbersUtils().isEven(-2.1!))
            buTest().assertTrue(buNumbersUtils().isEven(2.1!))
            buTest().assertTrue(buNumbersUtils().isEven(2))
            buTest().assertTrue(buNumbersUtils().isEven(-2))
            buTest().assertTrue(buNumbersUtils().isEven(0))
        end function,

        testBin2dec: function() as Void
            buTest().assertEquals(buNumbersUtils().bin2dec("1111"), 15)
        end function

        testHex2dec: function() as Void
            buTest().assertEquals(buNumbersUtils().hex2dec("0x80"), 128)
            buTest().assertEquals(buNumbersUtils().hex2dec("FF"), 255)
        end function

        testRad2deg: function() as Void
            buTest().assertEquals(buNumbersUtils().rad2deg(buNumbersUtils().PI), 180)
        end function

        testDeg2rad: function() as Void
            buTest().assertEquals(buNumbersUtils().deg2rad(180), buNumbersUtils().PI)
        end function

        testFactorial: function() as Void
            buTest().assertEquals(buNumbersUtils().factorial(0), 1)
            buTest().assertEquals(buNumbersUtils().factorial(-100), -1)
            buTest().assertEquals(buNumbersUtils().factorial(1), 1)
            buTest().assertEquals(buNumbersUtils().factorial(2), 2)
            buTest().assertEquals(buNumbersUtils().factorial(5), 120)
            buTest().assertEquals(buNumbersUtils().factorial(4.2!), 24)
        end function

        testAverage: function() as Void
            buTest().assertEquals(buNumbersUtils().average([2,8,11]), 7)
            buTest().assertEquals(buNumbersUtils().average([]), 0)
            buTest().assertEquals(buNumbersUtils().average([1]), 1)
        end function

        addSuite: function() as Void
            suite = {
                name: "buNumbersUtilsTests",
                tests: [
                    { name: "testMax", test: m.testMax },
                    { name: "testMin", test: m.testMin },
                    { name: "testCeiling", test: m.testCeiling },
                    { name: "testFloor", test: m.testFloor },
                    { name: "testRound", test: m.testRound },
                    { name: "testIsOdd", test: m.testIsOdd },
                    { name: "testIsEven", test: m.testIsEven },
                    { name: "testBin2dec", test: m.testBin2dec },
                    { name: "testHex2dec", test: m.testHex2dec },
                    { name: "testRad2deg", test: m.testRad2deg },
                    { name: "testDeg2rad", test: m.testDeg2rad },
                    { name: "testFactorial", test: m.testFactorial },
                    { name: "testAverage", test: m.testAverage },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
