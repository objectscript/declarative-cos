Class DeclarativeCOS.Binder Extends %RegisteredObject
{

Property collection As %Collection.AbstractList [ Private ];

Property function As %String [ Private ];

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

Method GetCollection()
{
    return ..collection
}

Method GetFunction()
{
    return ..function
}

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

Method Exists()
{
    return ..Find() '= ""
}

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

ClassMethod loadDeclarative(function As %String)
{
    return ##class(DeclarativeCOS.DeclarativesManager).loadDeclarative(function)
}

}

