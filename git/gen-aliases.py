#!/usr/bin/env python3

import sys
import re

script = sys.argv[1]
out_file = sys.argv[2]

aliases = {}

with open(script) as file:
    lines = file.read().split('\n')
    
    name = ""
    func_string = ""
    
    for line in lines:
        name_match = re.match('^([\w-]*)\(\) {$', line)
        if name_match:
            name = name_match.groups()[0]
        elif line == '}':
            aliases[name] = func_string
            func_string = ""
        elif not line.lstrip().startswith('#'):
            semi = ";"
            stripped = func_string.rstrip();
            if (
                stripped.endswith(' then')
                or stripped.endswith(' else')
                or stripped.endswith(' do')
                or stripped.endswith(';')
                or stripped.endswith('{')
                or stripped == ''
            ):
                semi = ""
            func_string = func_string + semi + line

with open(out_file, 'w') as out:
    contents = "[alias]\n"
    for name, func_string in aliases.items():
        escaped = func_string.replace('\\', '\\\\').replace('"', '\\"')
        contents = contents + '%s="!f() { %s; }; f"\n' % (name, escaped)
    out.write(contents)

