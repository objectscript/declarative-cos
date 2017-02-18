Class DeclarativeCOS.JoinerTests Extends %UnitTest.TestCase
{

Method TestJoin()
{
    set words = ##class(%ListOfDataTypes).%New()
    do words.Insert("DeclarativeCOS")
    do words.Insert("is")
    do words.Insert("awesome!")

    do $$$AssertEquals("DeclarativeCOS is awesome!", $zjoin(words, " "), "$zjoin must concatenate collection using separator")
}

}

