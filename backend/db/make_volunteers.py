import sys

if __name__ == "__main__":
	manager_id = 1
	for i in range(1,41):
		print(f"{i}	volunteer{i}.uname	volunteer{i}.pw	volunteer{i}.name	volunteer{i}@health_example.com	{manager_id}")
		if (i%10 == 0):
			manager_id += 1
