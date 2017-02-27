/// Binder collection with function.
/// Also, class provides implementation of all DeclarativeCOS commands and functions.
Class DeclarativeCOS.Binder Extends %RegisteredObject
{

/// Source collection for processing in DeclarativeCOS commands and functions.
Property collection As %Collection.AbstractList [ Private ];

/// Source function for processing in DeclarativeCOS commands and functions.
Property function As %String [ Private ];

/// Overrides "constructor" for the class.
Method %OnNew(collection As %Collection.AbstractList, function As %String) As %Status [ Private, ServerOnly = 1 ]
{
    if ('##class(DeclarativeCOS.Utils).isValidName(function)) {
        set exception = ##class(%Exception.General).%New("Declarative name is invalid", "1",,"Declarative name pattern must be ""namespace:function"".")

        throw exception
    }

    set ..collection = collection

    set ..function = ##class(DeclarativeCOS.Utils).normalizeName(function)

    return $$$OK
}

/// Returns source collection of the binder.
Method GetCollection()
{
    return ..collection
}

/// Returns source function of the binder.
Method GetFunction()
{
    return ..function
}

///
/// Implementation of "zforeach" command.
///
/// Applies the certain function to each element of the collection.
///
/// Example:
///   NAMESPACE> set collection = ##class(%ListOfDataTypes).%New()
///   NAMESPACE> do collection.Insert("Hello ")
///   NAMESPACE> do collection.Insert("World!")
///   NAMESPACE>
///   NAMESPACE> zforeach $zbind(collection, "io:print")
///
/// See also:
///   DeclarativeCOS.Binder
///   DeclarativeCOS.IO#print
///
Method ForEach()
{
    quit:..collection=""

    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        do $classmethod(className, methodName, item)
    }
}

///
/// Implementation of "$zmap" function.
///
/// Returns new collection where each item is result of apply the certain function to source item of the specified collection.
///
/// Example:
///   NAMESPACE> set numbers = ##class(%ListOfDataTypes).%New()
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE>
///   NAMESPACE> write "[" _ $zjoin(numbers, ",") _ "]"
///   NAMESPACE> [82,12,27]
///   NAMESPACE>
///   NAMESPACE> set hexNumbers = $zmap(numbers, "examples:toHex")
///   NAMESPACE>
///   NAMESPACE> for i=1:1:numbers.Count() { do numbers.SetAt($zhex(numbers.GetAt(i)), i) }
///   NAMESPACE>
///   NAMESPACE> write "[" _ $zjoin(numbers, ",") _ "]"
///   NAMESPACE> [52,C,1B]
///   NAMESPACE>
///   NAMESPACE> write $zjoin(hexNumbers, ",")
///   NAMESPACE> [52,C,1B]
///
/// See also:
///   DeclarativeCOS.Examples#toHex
///   DeclarativeCOS.Joiner#join ($zjoin)
///
Method Map()
{
    set collection = $classmethod(..collection.%ClassName(), "%New")

    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        set mappedItem = $classmethod(className, methodName, item)

        do collection.Insert(mappedItem)
    }

    return collection
}

///
/// Implementation of "$zfind" function.
///
/// Returns the first found element from the specified collection by the certain criteria (function).
/// Otherwise, returns null string.
///
/// Example:
///   NAMESPACE> set numbers = ##class(%ListOfDataTypes).%New()
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE>
///   NAMESPACE> set primeNumber = $zfind(numbers, "examples:isPrime")
///   NAMESPACE>
///   NAMESPACE> write "[" _ $zjoin(numbers, ",") _ "]"
///   NAMESPACE> [69,41,68]
///   NAMESPACE>
///   NAMESPACE> write "Prime number: " _ $select(primeNumber="":"<not found>", 1:primeNumber)
///   NAMESPACE> Prime number: 41
///
/// See also:
///   DeclarativeCOS.Examples#isPrime
///   DeclarativeCOS.Joiner#join ($zjoin)
///
Method Find()
{
    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        if ($classmethod(className, methodName, item)) {
            return item
        }
    }

    return ""
}

///
/// Implementation of "$zfilter" function.
///
/// Returns new collection which contains filtered elements by the certain criteria (function) of the specified collection.
///
/// Example:
///   NAMESPACE> set numbers = ##class(%ListOfDataTypes).%New()
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE>
///   NAMESPACE> set filteredNumbers = $zfilter(numbers, "examples:isOdd")
///   NAMESPACE>
///   NAMESPACE> write "[" _ $zjoin(numbers, ",") _ "]"
///   NAMESPACE> [22,71,31]
///   NAMESPACE>
///   NAMESPACE> write "[" _ $zjoin(filteredNumbers, ",") _ "]"
///   NAMESPACE> [71,31]
///
/// See also:
///   DeclarativeCOS.Examples#isOdd
///   DeclarativeCOS.Joiner#join ($zjoin)
///
Method Filter()
{
    set collection = $classmethod(..collection.%ClassName(), "%New")

    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        if ($classmethod(className, methodName, item)) {
            do collection.Insert(item)
        }
    }

    return collection
}

///
/// Implementation of "$zexists" function.
///
/// Returns $$$YES if collection contains element which is satisfied by by the certain criteria (function).
/// Otherwise, returns $$$NO.
///
/// Example:
///   NAMESPACE> set numbers = ##class(%ListOfDataTypes).%New()
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE> do numbers.Insert($random(100))
///   NAMESPACE>
///   NAMESPACE> set hasEvenNumbers = $zexists(numbers, "examples:isEven")
///   NAMESPACE>
///   NAMESPACE> write "[" _ $zjoin(numbers, ",") _ "]"
///   NAMESPACE> [51,56,53]
///   NAMESPACE>
///   NAMESPACE> write "Collection has" _ $case(hasEvenNumbers, 1:" ", 0:" no ") _ "even numbers"
///   NAMESPACE> Collection has even numbers
///
/// See also:
///   DeclarativeCOS.Examples#isEven
///   DeclarativeCOS.Joiner#join ($zjoin)
///
Method Exists()
{
    return ..Find() '= ""
}

///
/// Implementation of "$zcount" function.
///
/// Returns $$$YES if collection contains element which is satisfied by the certain criteria (function).
/// Otherwise, returns $$$NO.
///
/// Example:
///   NAMESPACE> set numbers = ##class(%ListOfDataTypes).%New()
///   NAMESPACE> do numbers.Insert($random(1000))
///   NAMESPACE> do numbers.Insert($random(1000))
///   NAMESPACE> do numbers.Insert($random(1000))
///   NAMESPACE>
///   NAMESPACE> set palindromicNumbersCount = $zcount(numbers, "examples:isPalindromic")
///   NAMESPACE>
///   NAMESPACE> write "[" _ $zjoin(numbers, ",") _ "]"
///   NAMESPACE> [715,202,898]
///   NAMESPACE>
///   NAMESPACE> write "Count of palindromic numbers: " _ palindromicNumbersCount
///   NAMESPACE> Count of palindromic numbers: 2
///
/// See also:
///   DeclarativeCOS.Examples#isPalindromic
///   DeclarativeCOS.Joiner#join ($zjoin)
///
Method Count()
{
    set count = 0

    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        if ($classmethod(className, methodName, item)) {
            set count = count + 1
        }
    }

    return count
}

/// Delegates call to DeclarativesManager#loadDeclarative
///
/// See also:
///   DeclarativeCOS.DeclarativesManager#loadDeclarative
///
ClassMethod loadDeclarative(function As %String) [ Private ]
{
    return ##class(DeclarativeCOS.DeclarativesManager).loadDeclarative(function)
}

}

