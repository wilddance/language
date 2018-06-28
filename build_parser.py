#!/usr/bin/python3
import os

pph_path = 'parser.ypp' # parser placeholder path
p_out_path = './out/parser.ypp'
placeholder= "PLACEHOLDER"

parser = open(pph_path).read()

grammars = ""

for f in os.listdir("grammars"):
    print("Reading %s" % f)
    grammars += "".join(open("grammars/%s" % f).readlines()[2:])

parser = parser.replace(placeholder, grammars)

print("Done")
fd = open(p_out_path, 'w')
fd.write(parser)
fd.close()


