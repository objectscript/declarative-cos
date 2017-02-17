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

/// @Declarative("math:is2")
ClassMethod is2(value As %Numeric)
{
    return value # 2 = 0
}

}

