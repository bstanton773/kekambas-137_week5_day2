# Complete the solution so that the function will break up camel casing, using a space between words. 
# The function should return a new string.

# Camel case is a way of writing phrases without spaces, where the first letter of each word is capitalized, 
# except for the first letter of the entire compound word, which may be either upper or lower case

# "camelCasing" = >  "camel Casing"
# "uncamelThisCamel" = >  "uncamel This Camel"
# "helloWorld" = >  "hello World"
# "thisIsAnotherCamelCasing" = >  "this Is Another Camel Casing"

import re
def solution(camel_string):
    return re.sub('[A-Z]', lambda m: ' ' + m.group(), camel_string)

def solution(camel_string):
    words = re.findall('[a-zA-Z][a-z]*', camel_string)
    return ' '.join(words)

def solution(camel_string):
    output = ''
    for char in camel_string:
        if char.isupper():
            output += ' '
        output += char
    return output
