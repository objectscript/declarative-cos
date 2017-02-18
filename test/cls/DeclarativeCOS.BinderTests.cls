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

/// @Declarative("test.map:nameNumber")
ClassMethod nameNumber(value As %Numeric) As %String
{
    return $select(value=1:"one", value=2:"two", value=3:"three", 1:"")
}

/// @Declarative("test.find:isEven")
ClassMethod isEven(value As %Numeric)
{
    return value # 2 = 0
}

/// @Declarative("test.filter:isOdd")
ClassMethod isOdd(value As %Numeric)
{
    return '..isEven(value)
}

/// @Declarative("test.exists:isNameMaks")
ClassMethod isNameMaks(value As %String)
{
    return value = "Maks"
}

/// @Declarative("test.exists:isNamePeter")
ClassMethod isNamePeter(value As %String)
{
    return value = "Peter"
}

/// @Declarative("test.count:greateOrEqualThan2000")
ClassMethod greateOrEqualThan2000(value As %Numeric)
{
    return (value >= 2000)
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
    set (number1, number2, number3) = $lb(1, 2, 3)

    set numbers = ##class(%ListOfDataTypes).%New()
    do numbers.Insert(number1)
    do numbers.Insert(number2)
    do numbers.Insert(number3)

    set namedNumbers = $zmap(numbers, "test.map:nameNumber")

    do $$$AssertEquals(numbers.Count(), namedNumbers.Count(), "Numbers collections must have the same count of items")

    do $$$AssertEquals(numbers.%ClassName(), namedNumbers.%ClassName(), "Numbers collections must have the same class name")

    do $$$AssertEquals(..nameNumber(number1), namedNumbers.GetAt(number1), "1 == one")
    do $$$AssertEquals(..nameNumber(number2), namedNumbers.GetAt(number2), "2 == two")
    do $$$AssertEquals(..nameNumber(number3), namedNumbers.GetAt(number3), "3 == three")
}

Method TestFind()
{
    set (number1, number2, number3) = $lb(1, 2, 3)

    set numbers = ##class(%ListOfDataTypes).%New()
    do numbers.Insert(number1)
    do numbers.Insert(number2)
    do numbers.Insert(number3)

    set evenNumber = $zfind(numbers, "test.find:isEven")

    do $$$AssertEquals(number2, evenNumber, "2 is even")

    do numbers.RemoveAt(number2)

    do $$$AssertNotTrue($zfind(numbers, "test.find:isEven"), "Numbers collection has no even numbers now")
}

Method TestFilter()
{
    set $lb(number1, number2, number3) = $lb(1, 2, 3)

    set numbers = ##class(%ListOfDataTypes).%New()
    do numbers.Insert(number1)
    do numbers.Insert(number2)
    do numbers.Insert(number3)

    set oddNumbers = $zfilter(numbers, "test.filter:isOdd")

    do $$$AssertEquals(numbers.Count() - 1, oddNumbers.Count(), "Numbers collections contains only one even number")

    do $$$AssertEquals(numbers.%ClassName(), oddNumbers.%ClassName(), "Numbers collections must have the same class name")

    do $$$AssertEquals(number1, oddNumbers.GetAt(1), "1 is odd")
    do $$$AssertEquals(number3, oddNumbers.GetAt(2), "3 is odd")
}

Method TestExists()
{
    set $lb(nameMaks, nameJohn, nameDonny) = $lb("Maks", "John", "Donny")

    set names = ##class(%ListOfDataTypes).%New()
    do names.Insert(nameMaks)
    do names.Insert(nameJohn)
    do names.Insert(nameDonny)

    set isNameMaksExist = $zexists(names, "test.exists:isNameMaks")

    do $$$AssertTrue(isNameMaksExist, """Maks"" exists in names collection")

    set isNamePeterExist = $zexists(names, "test.exists:isNamePeter")

    do $$$AssertNotTrue(isNamePeterExist, """Peter"" doesn't exists in names collection")
}

Method TestCount()
{
    set $lb(year1998, year1999, year2000, year2001) = $lb(1998, 1999, 2000, 2001)

    set years = ##class(%ListOfDataTypes).%New()
    do years.Insert(year1998)
    do years.Insert(year1999)
    do years.Insert(year2000)
    do years.Insert(year2001)

    set expectedFilteredYears = ##class(%ListOfDataTypes).%New()
    do expectedFilteredYears.Insert(year2000)
    do expectedFilteredYears.Insert(year2001)

    set filteredYearsCount = $zcount(years, "test.count:greateOrEqualThan2000")

    do $$$AssertEquals(expectedFilteredYears.Count(), filteredYearsCount, "Only two years should be filtered")
}

}

