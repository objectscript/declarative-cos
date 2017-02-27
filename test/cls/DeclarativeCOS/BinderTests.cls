Class DeclarativeCOS.BinderTests Extends (%UnitTest.TestCase, DeclarativeCOS.DeclarativeProvider)
{

Parameter TESTGLOBALNAME As %String = "^DeclarativeCOSTests";

/// @Declarative("test.forEach:toGlobal")
ClassMethod toGlobal(word As %String)
{
    set global = $name(@..#TESTGLOBALNAME@("forEach"))

    if ('$data(@global@("word1"))) { set @global@("word1") = word }

    elseif ('$data(@global@("word2"))) { set @global@("word2") = word }

    elseif ('$data(@global@("word3"))) { set @global@("word3") = word }
}

Method TestForEach()
{
    set global = $name(@..#TESTGLOBALNAME@("forEach"))

    kill @global

    set $lb(word1, word2, word3) = $lb("ForEach", "is", "available")

    set words = ##class(%ListOfDataTypes).%New()
    do words.Insert(word1)
    do words.Insert(word2)
    do words.Insert(word3)

    zforeach $zbind(words, "test.forEach:toGlobal")

    do $$$AssertEquals(word1, $get(@global@("word1")), "Word #1 is equal")
    do $$$AssertEquals(word2, $get(@global@("word2")), "Word #2 is equal")
    do $$$AssertEquals(word3, $get(@global@("word3")), "Word #3 is equal")

    kill @global
}

Method TestMap()
{
    set numbers = ##class(%ListOfDataTypes).%New()

    for i=1:1:10 { do numbers.Insert($random(1000)) }

    set hexNumbers = $zmap(numbers, "examples:toHex")

    for i=1:1:numbers.Count() { do numbers.SetAt($zhex(numbers.GetAt(i)), i) }

    do $$$AssertEquals($zjoin(numbers, ","), $zjoin(hexNumbers, ","), "$zmap works!")
}

Method TestFind()
{
    set numbers = ##class(%ListOfDataTypes).%New()

    for i=1:1:10 { do numbers.Insert($random(1000)) }

    set expectedPrimeNumber = ""

    for i=1:1:numbers.Count() {
        set number = numbers.GetAt(i)

        if (##class(DeclarativeCOS.Examples).isPrime(number)) {
            set expectedPrimeNumber = number
        }

        quit:expectedPrimeNumber'=""
    }

    set actualPrimeNumber = $zfind(numbers, "examples:isPrime")

    do $$$AssertEquals(expectedPrimeNumber, actualPrimeNumber, "$zfind works!")
}

Method TestFilter()
{
    set numbers = ##class(%ListOfDataTypes).%New()

    for i=1:1:10 { do numbers.Insert($random(1000)) }

    set expectedFilteredNumbers = ##class(%ListOfDataTypes).%New()

    for i=1:1:numbers.Count() {
        set number = numbers.GetAt(i)

        if (##class(DeclarativeCOS.Examples).isOdd(number)) {
            do expectedFilteredNumbers.Insert(number)
        }
    }

    set actualFilteredNumbers = $zfilter(numbers, "examples:isOdd")

    do $$$AssertEquals($zjoin(expectedFilteredNumbers, ","), $zjoin(actualFilteredNumbers, ","), "$zfilter works!")
}

Method TestExists()
{
    set numbers = ##class(%ListOfDataTypes).%New()

    for i=1:1:10 { do numbers.Insert($random(1000)) }

    set expectedHasEvenNumber = $$$NO

    for i=1:1:numbers.Count() {
        set number = numbers.GetAt(i)

        if (##class(DeclarativeCOS.Examples).isEven(number)) {
            set expectedHasEvenNumber = $$$YES
        }

        quit:expectedHasEvenNumber'=""
    }

    set actualHasEvenNumber = $zexists(numbers, "examples:isEven")

    do $$$AssertEquals(expectedHasEvenNumber, actualHasEvenNumber, "$zexists works!")
}

Method TestCount()
{
    set numbers = ##class(%ListOfDataTypes).%New()

    for i=1:1:10 { do numbers.Insert($random(1000)) }

    set expectedPalindromicNumbersCount = 0

    for i=1:1:numbers.Count() {
        set number = numbers.GetAt(i)

        if (##class(DeclarativeCOS.Examples).isPalindromic(number)) {
            set expectedPalindromicNumbersCount = $increment(expectedPalindromicNumbersCount)
        }
    }

    set actualPalindromicNumbersCount = $zcount(numbers, "examples:isPalindromic")

    do $$$AssertEquals(expectedPalindromicNumbersCount, actualPalindromicNumbersCount, "$zcount works!")
}

}

