/// Manager for declaratives.
/// The class contains methods for saving and retrieving declaratives from ^DeclarativeCOS global.
Class DeclarativeCOS.DeclarativesManager
{

/// Stores declarative to the ^DeclarativeCOS global.
ClassMethod saveDeclarative(declarativeName As %String, className As %String, functionName As %String)
{
    set ^DeclarativeCOS("functions", declarativeName) = $lb(className, functionName)
}

/// Loads declarative from the ^DeclarativeCOS global.
ClassMethod loadDeclarative(declarativeName As %String)
{
    return $get(^DeclarativeCOS("functions", declarativeName))
}

}

