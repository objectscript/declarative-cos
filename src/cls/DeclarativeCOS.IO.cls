/// The class provides IO declaratives.
/// io:print <-> w value
/// io:println <-> w value, !
Class DeclarativeCOS.IO Extends DeclarativeCOS.DeclarativeProvider
{

/// Output passed value.
///
/// @Declarative("io:print")
ClassMethod print(value As %Library.DataType)
{
    w value
}

/// Output passed value. Add newline symbol.
///
/// @Declarative("io:println")
ClassMethod println(value As %Library.DataType)
{
    w value, !
}

}

