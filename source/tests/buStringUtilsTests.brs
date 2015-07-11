function buStringUtilsTests() as Object
    tests = {
        testIsEmpty: function() as Void
            buTest().assertTrue(buStringUtils().isEmpty(""))
            buTest().assertTrue(buStringUtils().isEmpty(" "))
            buTest().assertFalse(buStringUtils().isEmpty("f"))
            buTest().assertFalse(buStringUtils().isEmpty("f00"))
        end function,

        testIntToString: function() as Void
            buTest().assertEquals(buStringUtils().intToString(1), "1")
            buTest().assertEquals(buStringUtils().intToString(-1), "-1")
            buTest().assertEquals(buStringUtils().intToString(-1, true), "-1")
            buTest().assertEquals(buStringUtils().intToString(0, true), "00")
            buTest().assertEquals(buStringUtils().intToString(1, true), "01")
            buTest().assertEquals(buStringUtils().intToString(9, true), "09")
            buTest().assertEquals(buStringUtils().intToString(10, true), "10")
        end function,

        testDoubleToString: function() as Void
            buTest().assertEquals(buStringUtils().doubleToString(1.2#), "1.2")
        end function,

        testToString: function() as Void
            buTest().assertEquals(buStringUtils().toString(1), "1")
            buTest().assertEquals(buStringUtils().toString("1"), "1")
            buTest().assertEquals(buStringUtils().toString(1.2#), "1.2")
            buTest().assertEquals(buStringUtils().toString(1.2!), "1.2")
            buTest().assertEquals(buStringUtils().toString(true), "true")
            buTest().assertEquals(buStringUtils().toString(Invalid), "Invalid")
            buTest().assertEquals(buStringUtils().toString({}), "{}")
            buTest().assertEquals(buStringUtils().toString([]), "[]")
            buTest().assertEquals(buStringUtils().toString(["1","2","3"]), "[1,2,3]")
            buTest().assertEquals(buStringUtils().toString([1,2,3]), "[1,2,3]")
            buTest().assertEquals(buStringUtils().toString([1,2,3, [4,5,6]]), "[1,2,3,[4,5,6]]")

            complex = {
                a: 1,
                b: "test",
                c: [1,2,3],
                d: [
                    {x: 1, y: 2},
                    {x: 2, y: 3},
                    {x: 3, y: 4},
                ],
                e: createObject("roTimespan"),
                f: function() as Void

                end function
            }

            ' This may faile because a AA is not sorted
            buTest().assertEquals(buStringUtils().toString(complex), "{e:roTimespan,a:1,d:[{x:1,y:2},{x:2,y:3},{x:3,y:4}],c:[1,2,3],b:test,f:roFunction}")
        end function,

        testEquals: function() as Void
            buTest().assertTrue(buStringUtils().equals(1, 1))
            buTest().assertTrue(buStringUtils().equals("1", "1"))
            buTest().assertTrue(buStringUtils().equals(Invalid, Invalid))
            buTest().assertTrue(buStringUtils().equals(Invalid, "Invalid"))
            buTest().assertFalse(buStringUtils().equals("true", "false"))
            buTest().assertFalse(buStringUtils().equals("1", "0"))
        end function,

        testTruncate: function() as Void
            buTest().assertEquals(buStringUtils().truncate("LoremIpsum", 3), "Lor...")
            buTest().assertEquals(buStringUtils().truncate("LoremIpsum", 0), "...")
            buTest().assertEquals(buStringUtils().truncate("LoremIpsum", 10), "LoremIpsum")
        end function,

        testCapitalize: function() as Void
            buTest().assertEquals(buStringUtils().capitalize("LoremIpsum"), "Loremipsum")
            buTest().assertEquals(buStringUtils().capitalize("Loremipsum"), "Loremipsum")
            buTest().assertEquals(buStringUtils().capitalize("LOREMIPSUM"), "Loremipsum")
        end function,

        testSplit: function() as Void
            splitted = buStringUtils().split("Lorem,Ipsum", ",")
            buTest().assertEquals(splitted[0], "Lorem")
            buTest().assertEquals(splitted[1], "Ipsum")
        end function,

        testContains: function() as Void
            buTest().assertTrue(buStringUtils().contains("Lorem, Ipsum", ","))
            buTest().assertFalse(buStringUtils().contains("Lorem, Ipsum", "/."))
        end function,

        testIndexOf: function() as Void
            buTest().assertEquals(buStringUtils().indexOf("Lorem, Ipsum", ","), 5)
            buTest().assertEquals(buStringUtils().indexOf("Lorem, Ipsum", "/."), -1)
        end function,

        testLastIndexOf: function() as Void
            buTest().assertEquals(buStringUtils().lastIndexOf("Lorem, Ipsum, Lorem Sonet", ","), 13)
            buTest().assertEquals(buStringUtils().lastIndexOf("Lorem, Ipsum, Lorem, Sonet", ","), 20)
            buTest().assertEquals(buStringUtils().lastIndexOf("Lorem, Ipsum, Lorem, Sonet", "/."), -1)
        end function,

        testJoin: function() as Void
            buTest().assertEquals(buStringUtils().join(["Lor", "em"]), "Lorem")
            buTest().assertEquals(buStringUtils().join(["Lor", "em", 1]), "Lorem1")
            buTest().assertEquals(buStringUtils().join(["Lor", "em", 1, true]), "Lorem1true")
            buTest().assertEquals(buStringUtils().join([1,2,3]), "123")
            buTest().assertEquals(buStringUtils().join([1,2,3], ","), "1,2,3")
        end function,

        testToArray: function() as Void
            res = buStringUtils().toArray("Lorem")
            expected = ["L","o","r","e","m"]
            buTest().assertTrue(buArrayUtils().equals(res, expected))
        end function,

        testReverse: function() as Void
            buTest().assertEquals(buStringUtils().reverse("Lorem"), "meroL")
            buTest().assertEquals(buStringUtils().reverse(""), "")
        end function,

        testReplace: function() as Void
            buTest().assertEquals(buStringUtils().replace("Lorem, Ipsum", ",", "."), "Lorem. Ipsum")
        end function,

        testToMD5Hash: function() as Void
            a = buStringUtils().toMD5Hash("Lorem Ipsum")
            b = buStringUtils().toMD5Hash("Lorem Ipsum")
            c = buStringUtils().toMD5Hash("Lorem Ipsum 2")
            buTest().assertEquals(a, b)
            buTest().assertFalse(a = c)
        end function,

        testToSHA1Hash: function() as Void
            a = buStringUtils().toSHA1Hash("Lorem Ipsum")
            b = buStringUtils().toSHA1Hash("Lorem Ipsum")
            c = buStringUtils().toSHA1Hash("Lorem Ipsum 2")
            buTest().assertEquals(a, b)
            buTest().assertFalse(a = c)
        end function,

        testToSHA256Hash: function() as Void
            a = buStringUtils().toSHA256Hash("Lorem Ipsum")
            b = buStringUtils().toSHA256Hash("Lorem Ipsum")
            c = buStringUtils().toSHA256Hash("Lorem Ipsum 2")
            buTest().assertEquals(a, b)
            buTest().assertFalse(a = c)
        end function,

        testToSHA512Hash: function() as Void
            a = buStringUtils().toSHA512Hash("Lorem Ipsum")
            b = buStringUtils().toSHA512Hash("Lorem Ipsum")
            c = buStringUtils().toSHA512Hash("Lorem Ipsum 2")
            buTest().assertEquals(a, b)
            buTest().assertFalse(a = c)
        end function,

        testSubstitute: function() as Void
            buStringUtils().substitute("")

            buTest().assertEquals(buStringUtils().substitute(""), "")

            buTest().assertEquals(buStringUtils().substitute("Lorem"), "Lorem")
            buTest().assertEquals(buStringUtils().substitute("Lorem {0}", 1), "Lorem 1")
            buTest().assertEquals(buStringUtils().substitute("Lorem {0}, {1}", 1, 2), "Lorem 1, 2")
            buTest().assertEquals(buStringUtils().substitute("Lorem {0}, {1}, {2}", 1, 2, 3), "Lorem 1, 2, 3")

            buTest().assertEquals(buStringUtils().substitute("Lorem {0}"), "Lorem Invalid")
            buTest().assertEquals(buStringUtils().substitute("Lorem {0}, {1}", 1), "Lorem 1, Invalid")
            buTest().assertEquals(buStringUtils().substitute("Lorem {0}, {1}, {2}", 1, 2), "Lorem 1, 2, Invalid")
        end function,

        addSuite: function() as Void
            suite = {
                name: "buStringUtilsTests",
                tests: [
                    { name: "testIsEmpty", test: m.testIsEmpty },
                    { name: "testIntToString", test: m.testIntToString },
                    { name: "testDoubleToString", test: m.testDoubleToString },
                    { name: "testToString", test: m.testToString },
                    { name: "testEquals", test: m.testEquals },
                    { name: "testTruncate", test: m.testTruncate },
                    { name: "testCapitalize", test: m.testCapitalize },
                    { name: "testSplit", test: m.testSplit },
                    { name: "testContains", test: m.testContains },
                    { name: "testIndexOf", test: m.testIndexOf },
                    { name: "testLastIndexOf", test: m.testLastIndexOf },
                    { name: "testJoin", test: m.testJoin },
                    { name: "testToArray", test: m.testToArray },
                    { name: "testReverse", test: m.testReverse },
                    { name: "testReplace", test: m.testReplace },
                    { name: "testToMD5Hash", test: m.testToMD5Hash },
                    { name: "testToMD5Hash", test: m.testToSHA1Hash },
                    { name: "testToMD5Hash", test: m.testToSHA256Hash },
                    { name: "testToMD5Hash", test: m.testToSHA512Hash },
                    { name: "testSubstitute", test: m.testSubstitute }
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
