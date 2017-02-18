Class DeclarativeCOS.IO Extends DeclarativeCOS.DeclarativeProvider
{

/// @Declarative("io:print")
ClassMethod print(value As %Library.DataType)
{
    w value
}

/// @Declarative("io:println")
ClassMethod println(value As %Library.DataType)
{
    w value, !
}

}

