Class DeclarativeCOS.DeclarativeProvider
{

ClassMethod register() [ CodeMode = objectgenerator ]
{
    s methods = %compiledclass.Methods

    s i = ""  

    for {
        s i = methods.Next(i)

        q:i=""

        s method = methods.GetAt(i)

        s methodName = method.Name

        s methodDescription = method.Description

        continue:methodName="register"

        continue:$extract(methodName)="%"

        s annotationRegexp = "@Declarative\s+\[\s*(\w+\s*\:\s*\w+)\s*\]"

        s annotationMatcher = ##class(%Regex.Matcher).%New(annotationRegexp, methodDescription)

        if (annotationMatcher.Locate()) {
            s annotationValue = $replace(annotationMatcher.Group(1), " ", "")

            s ^DeclarativeCOS(annotationValue, "class") = %compiledclass.Name
            s ^DeclarativeCOS(annotationValue, "method") = methodName
        }
    }

    d %code.WriteLine("    q")

    q $$$OK
}

}

