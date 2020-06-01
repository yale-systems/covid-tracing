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
	man_id = 1
	vol_id = 1
	for i in range(1,101):
		# 100 patients
		uname = f"patient{i}.username"
		pw = f"patient{i}.pw"
		name = f"patient{i}.name"
		email = f"patient{i}@example.com"
		patient_string = f"{i}	{uname}	{pw}	{name}	{email}	{man_id}	{vol_id}"
		print(patient_string)

		if (i%3 == 0):
			vol_id += 1
		if (i%30) == 0:
			man_id += 1
	print()

	for entry in patient_data.values():
		print(f"{entry.group(1)}	{entry.group(2)}	{entry.group(3)}	{entry.group(4)}	{entry.group(5)}	{entry.group(6)}")
		#print(entry)
