# Welcome to the DeclarativeCOS!
<br/>
<br/>
<br/>
# What is DeclarativeCOS?

DeclarativeCOS - is another view to programming on the Caché ObjectScript language. It allows you to write the code in declarative style.
<br/>
<br/>
# What is declarative style in COS?

Declarative style in COS means that you write the code as a statement which describes what you need to do.
<br/>
<br/>
# What is the difference from my one-liners code?

The main point is not to add one-liners features to COS. The main point is to bring another kind of mind when you do your task. DeclarativeCOS allows to remove regular loops from your code, because you really don't need it.
<br/>
<br/>
# What is the problem with my regular loops in COS?

Loop is just an instrument to solve the problem. In common, the problem is to traverse by collection and do some action with every element. Do you really need a loop for it? No. You choose a loop because COS supports loops only. DeclarativeCOS allows to write the code in declarative style. Just declare what you want to do and DeclarativeCOS will do all the rest for you.
<br/>
<br/>
# OK. How does it work?

**5 steps:**
- Extends from DeclarativeCOS.DeclarativeProvider.
- Implement class method.
- Mark the method.
- Use one of provided DeclarativeCOS statements.
- Enjoy the result.

<br/>
<br/>
# Any example, please.

Suppose, we need to output all items of the list (for example, list is instance of [%ListOfDataTypes](http://docs.intersystems.com/latest/csp/documatic/%25CSP.Documatic.cls?PAGE=CLASS&LIBRARY=%25SYS&CLASSNAME=%25Library.ListOfDataTypes)).

**Step 1. Extends from DeclarativeCOS.DeclarativeProvider.**
```
Class MyPackage.IO extens DeclarativeProvider
{
}
```

**Step 2. Implement class method.**
```
Class MyPackage.IO extens DeclarativeProvider
{

ClassMethod print(value As %String)
{
    w value
}

}
```

**Step 3. Mark the method.**
```
Class MyPackage.IO extens DeclarativeProvider
{

/// @Declarative("io:print")
ClassMethod print(value As %String)
{
    w value
}

}
```

**Step 4. Use one of provided DeclarativeCOS statements.**
```
s words = ##class(%Library.ListOfDataTypes).%New()
d words.Insert("Hello ")
d words.Insert("World!")

zforeach $zbind(words, "io:print")
```

**Step 5. Enjoy the result.**
```
Hello World!
```
<br/>
# What is about LICENCE?

MIT License

Copyright (c) 2017 InterSystems Corporation

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.