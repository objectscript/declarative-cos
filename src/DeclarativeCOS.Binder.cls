Class DeclarativeCOS.Binder Extends %RegisteredObject
{

Property collection As %Collection.AbstractList [ Private ];

Property function As %String [ Private ];

Method %OnNew(collection As %Collection.AbstractList, function As %String) As %Status [ Private, ServerOnly = 1 ]
{
    set ..collection = collection

    set ..function = $replace(function, " ", "")

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
    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        do $classmethod($get(^DeclarativeCOS(..function, "class")), $get(^DeclarativeCOS(..function, "method")), item)
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

        set mappedItem = $classmethod($get(^DeclarativeCOS(..function, "class")), $get(^DeclarativeCOS(..function, "method")), item)

        do collection.Insert(mappedItem)
    }

    return collection
}

}

