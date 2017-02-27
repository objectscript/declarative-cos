/// Some utils for DeclarativeCOS implementation.
Class DeclarativeCOS.Utils
{

/// Declarative name regular expression.
/// The pattern is "namespace:function"
Parameter DECLARATIVENAMEREGEX [ Internal ] = "[a-zA-Z0-9]+(.[a-zA-Z0-9]+)*\s*:\s*[a-zA-Z0-9]+([a-zA-Z0-9_]+)*";

/// Returns $$$YES if specified name is satisfied by the DECLARATIVENAMEREGEX regex.
/// Otherwise, returns $$$NO.
ClassMethod isValidName(name As %String) As %Boolean
{
    return ##class(%Regex.Matcher).%New("^" _ ..#DECLARATIVENAMEREGEX _ "$", name).Locate()
}

/// Returns declarative name without any space characters.
ClassMethod normalizeName(name As %String) As %String
{
    if (..isValidName(name)) {
        return $replace(name, " ", "")
    }

    return name
}

}

