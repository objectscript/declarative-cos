/// Joiner is a kind of text utils class.
/// The main point of the class is join elemenet of collection using separator.
Class DeclarativeCOS.Joiner
{

/// Returns string from elements of the specified collection usin the certain separator.
/// Example:
///   NAMESPACE> set words = ##class(%ListOfDataTypes).%New()
///   NAMESPACE> do words.Insert("DeclarativeCOS")
///   NAMESPACE> do words.Insert("is")
///   NAMESPACE> do words.Insert("awesome!")
///   NAMESPACE>
///   NAMESPACE> write $jzoin(words, " ")
///   NAMESPACE> DeclarativeCOS is awesome!
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

