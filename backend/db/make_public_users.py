import sys
import re



def id_repl(match_obj):
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
	patient_data = dict()
	re_string = "^([0-9]*)\s+([0-9]*)\s+([0-9-]* [0-9:]*)\s+([0-9-]* [0-9:]*)\s+([ft])\s([0-aA-F]*)"
	# matches pk_id, patient_id, start_time, end_time, confirmed, geom
	matcher = re.compile(re_string)

	for raw_line in sys.stdin:
		line = raw_line.rstrip()
		match = re.match(matcher, line)
		if match != None:
			patient_data[int(match.group(1))] = match


	patients = dict()
	for i in range(1,98):
		# 100 patients
		uname = f"pub_user{i}.username"
		pw = f"pub_user{i}.pw"
		name = f"pub_user{i}.name"
		email = f"pub_user{i}@public_example.com"
		patient_string = f"{i}	{uname}	{pw}	{name}	{email}"
		print(patient_string)

	print()

	for entry in patient_data.values():
		print(f"{int(entry.group(1)) - 4350}	{int(entry.group(2))-100}	{entry.group(3)}	{entry.group(4)}	{entry.group(5)}	{entry.group(6)}")
		#print(entry)
