import re

print(re.match(r'c#(?![a-zA-Z])', 'c#>'))  # None