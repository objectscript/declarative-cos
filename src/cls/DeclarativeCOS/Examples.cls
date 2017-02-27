/// Set of DeclarativeCOS examples.
Class DeclarativeCOS.Examples Extends DeclarativeCOS.DeclarativeProvider
{

/// Returns hex value of the passed value.
///
/// @Declarative("examples:toHex")
ClassMethod toHex(value As %Numeric)
{
    return $zhex(value)
}

/// Returns $$$YES if passed value is prime number.
/// Otherwise, returns $$$NO.
///
/// @Declarative("examples:isPrime")
ClassMethod isPrime(value As %Numeric)
{
    for i=2:1:$zsqr(value) {
        if (value # i = 0) {
            return $$$NO
        }
    }

    return $$$YES
}

/// Returns $$$YES if passed value is odd number.
/// Otherwise, returns $$$NO.
///
/// @Declarative("examples:isOdd")
ClassMethod isOdd(value As %Numeric)
{
    return value # 2 '= 0
}

/// Returns $$$YES if passed value is even number.
/// Otherwise, returns $$$NO.
///
/// @Declarative("examples:isEven")
ClassMethod isEven(value As %Numeric)
{
    return value # 2 = 0
}

/// Returns $$$YES if passed value is palindromic number.
/// Otherwise, returns $$$NO.
///
/// @Declarative("examples:isPalindromic")
ClassMethod isPalindromic(value As %Numeric)
{
    return $reverse(value) = value
}

}

