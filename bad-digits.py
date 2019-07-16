#!/usr/bin/env python

import sys

# everything equal or above this value is ok and saved to output
min_good = 4

out = []
bad = []

count = 0
limit = 50

input_file = sys.argv[1]
with open(input_file, 'r') as f:
	for line in f:
		if count == limit:
			break
		#count += 1
		uniq = set([num for num in str(line.split(':')[2])])
		#print(line)
		#print(str(uniq) + ' len = ' + str(len(uniq)))
		if len(uniq) >= (min_good + 1):
			out.append(line)
		else:
			bad.append(line)

print('-> Bad setemids filtered out!')
output_file = input_file + '.out'
with open(output_file, 'w') as f:
	for el in out:
		f.write(el)

print('-> Data saved to file %s' % (output_file))

output_file = input_file + '.bad'
with open(output_file, 'w') as f:
        for el in bad:
                f.write(el)

print('-> Data saved to file %s' % (output_file))
