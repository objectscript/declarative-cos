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

}

