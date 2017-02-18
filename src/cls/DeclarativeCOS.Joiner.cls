Class DeclarativeCOS.Joiner
{

ClassMethod join(collection As %Collection.AbstractList, separator As %String = "") As %String
{
    if (collection = "") {
      return ""
    }

    set string = ""

    set index = ""

    for {
        set index = collection.Next(index)

        quit:index=""

        set item = collection.GetAt(index)

        if (string = "") {
            set string = "" _ item
        }
        else {
            set string = string _ separator _ item
        }
    }

    return string
}

}

