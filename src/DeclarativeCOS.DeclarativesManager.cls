Class DeclarativeCOS.DeclarativesManager
{

ClassMethod saveDeclarative(declarativeName As %String, className As %String, functionName As %String)
{
    set ^DeclarativeCOS("functions", declarativeName) = $lb(className, functionName)
}

ClassMethod loadDeclarative(declarativeName As %String)
{
    return $get(^DeclarativeCOS("functions", declarativeName))
}

}

