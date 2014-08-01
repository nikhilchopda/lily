Lily
=====

```
<html>
<@lily print("Hello, world!") @>
</html>
```

Lily is a statically-typed language that can be used to make dynamically generated content (similar to PHP) or be run by itself.

The language currently recognizes 8 datatypes:

* integer: A 64-bit signed int.
* number: A C double.
* string: A bunch of text.
* list: A list of a given element.
* hash: An associative array, having a key and value type.
* function: A callable body of code. Some are native (defined by Lily code), and some are foreign (defined outside of Lily code). The interpreter doesn't make a distinction.
* object: Anything.

Values must be declared before they are used:
```
# This is a comment
# Here's some basic initializations.
integer a = 10
number b = 10.1
string c = "abc"

# This is a list of integers. It will only take integers.
list[integer] d = [1, 2, 3]

# This is a hash that takes integers, and gives strings.
hash[integer, string] e = [1 => "10", 2 => "20"]

# Here's a function that returns an integer:
function return_10():integer
{
    return 10
}
# To return no value, use 'nil'.

# How about something more difficult?
list[function():integer] function_list = [return_10, return_10, return_10]

# Subscript results can be called.
function_list[1]()

list[list[integer]] multiple_dimensions = [1, 2, 3], [4, 5, 6], [7, 8, 9]

But what about objects?

object o
o = function_list
o = multiple_dimensions
o = return_10
o = 11
```

Okay, so what can things actually do?

* Integers can do these operations: + - * / << >> % & | ^
* Numbers can do these operations: + - * / %
* Integers, numbers, and strings can all be compared using < > <= >= ==

```
function letter_for_grade(integer grade):string
{
	str letter
	# Each condition has a : after it, similar to Python.
	# Indentation is NOT enforced though.
	# Each condition allows one expression, no more.
	if grade >= 90:
		letter = "A"
	elif grade >= 80:
		letter = "B"
	elif grade >= 70:
		letter = "C"
	elif grade >= 60:
		letter = "D"
	else:
		letter = "F"

	return letter
}

# How about something multi-line though?

function something(integer abc):nil {  }

function algorithm(integer a):integer
{
	integer ret
	if a == 10: { # This starts the multi-line block
		ret = 11
		something(55)
		something(12)
	elif a == 11:
		ret = 12
		something(123)
		something(456)
	else:
		ret = 13
	} # This closes it.

	return ret
}
```

The following block types are supported:
* if/elif/else
* for i in a..b: ...
* while condition: ...
* do: ... while x:

Lily also supports continue and break within loops.

Types can also get pretty complex:
```
list[object] olist = [1, 1.1, [1], "1"]

# A typecast is needed to get data out of an object. It looks like this:
# value.@(type)
integer abc = olist[0].@(integer)

# Typecasts allow access to the values with objects while retaining static typing.
# Typecasts can also convert integers to/from numbers:

integer a = 1.1.@(integer)


function r(): list[integer] { return [1, 2, 3] }
```

Here are some other nifty things:

```
Functions can take type variable arguments:

# The variable arguments are all thrown together in a list.
function total_values(list[integer] values...):integer
{
	int output = 0
	for i in 1..values.size()
		output += i

	return i

}

# show is a keyword that displays whatever is given to it:
show 10
show [1, 2, 3]
show [1 => "1"]
# show is a nice tool for both debugging and curious inspection of things.
```

The following are the functions that come with Lily:
* print(text): This prints a string to stdout
* printfmt(fmt, object...): This uses format strings to print the objects given.
* %i for integer, %n for a number, %s for a string.

The sanity test (src/test/pass/sanity.ly) contains more examples of what the language can do.
