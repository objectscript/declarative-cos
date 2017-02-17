Class DeclarativeCOS.Utils
{

Parameter DECLARATIVENAMEREGEX [ Internal ] = "[a-zA-Z0-9]+(.[a-zA-Z0-9]+)*\s*:\s*[a-zA-Z0-9]+([a-zA-Z0-9_]+)*";

ClassMethod isValidName(name As %String) As %Boolean
{
    return ##class(%Regex.Matcher).%New("^" _ ..#DECLARATIVENAMEREGEX _ "$", name).Locate()
}

ClassMethod normalizeName(name As %String) As %String
{
    if (..isValidName(name)) {
        return $replace(name, " ", "")
    }

    return name
}

}

