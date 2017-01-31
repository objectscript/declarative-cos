Class DeclarativeCOS.DeclarativeProvider
{

ClassMethod register() [ CodeMode = objectgenerator ]
{
    if (%compiledclass.Name = "DeclarativeCOS.DeclarativeProvider") {
        kill ^DeclarativeCOS
    }

    set methods = %compiledclass.Methods

    set i = ""

    for {
        set i = methods.Next(i)

        quit:i=""

        set method = methods.GetAt(i)

        set methodName = method.Name

        set methodDescription = method.Description

        continue:methodName="register"

        continue:$extract(methodName)="%"

        set annotationRegexp = "@Declarative\s+\[\s*(\w+\s*\:\s*\w+)\s*\]"

        set annotationMatcher = ##class(%Regex.Matcher).%New(annotationRegexp, methodDescription)

        if (annotationMatcher.Locate()) {
            set annotationValue = $replace(annotationMatcher.Group(1), " ", "")

            do ##class(DeclarativeCOS.DeclarativesManager).saveDeclarative(annotationValue, %compiledclass.Name, methodName)
        }
    }

    d %code.WriteLine("    q")

    q $$$OK
}

}

