import sys
import re
# CURRENLY IN PROGRESS

ids = dict()
next_id = 1

def id_repl(match_obj):
	global ids
	global next_id
	# returns the id that should be replaced, inserting it into `ids` if necessary 
	#IF id not seen before
		# add to dictionary	
	#return string to replace - str of id
	key = int(match_obj.group(2))
	if key not in ids:
		ids[key] = str(next_id)
		next_id += 1
	return f"{match_obj.group(1)}{ids[key]}{match_obj.group(3)}"

if __name__ == "__main__":
	re_string = "^([0-9]*\s+)([0-9]*)(\s*[0-9]{4})"
	matcher = re.compile(re_string)

	for raw_line in sys.stdin:
		line = raw_line.rstrip()
		output = re.sub(matcher, id_repl, line)
		print(output)

