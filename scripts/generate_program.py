# generate_program.py

print("running\n")

with open("../programs/program.mem", "w") as f:
    for i in range(1024):
        f.write(f"{i:08X}\n")
