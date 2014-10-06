from os import *

Inst2OpCode = { 'LW' : '100011',
				'SW' : '101011',
				'BEQ' : '000100',
				'JUMP' : '000101',
				'ADDI' : '001000',
				'PRREG' : '111111',
				'PRMEM' : '111110',
				'ADD' : '000000',
				'SUB' : '000000',
				'AND' : '000000',
				'OR' : '000000',
				'SLT' : '000000' }

Inst2Fuct = { 'ADD' : '000000', 'SUB' : '000001', 'AND' : '000010', 'OR' : '000011', 'SLT' : '000100' }

b2Hex = {   '0000' : '0', '0001' : '1', '0010' : '2', '0011' : '3',
			'0100' : '4', '0101' : '5', '0110' : '6', '0111' : '7',
			'1000' : '8', '1001' : '9', '1010' : 'A', '1011' : 'B',
			'1100' : 'C', '1101' : 'D', '1110' : 'E', '1111' : 'F' }
def binaryConvert(no, select=0):
	noB = no
	binarySeq = ""
	while(noB != 0):
		binarySeq = str(noB%2) + binarySeq
		noB = noB/2
	if select == 1:
		allowedLength = 16
	else:
		allowedLength = 5
	while len(binarySeq) < allowedLength:
		binarySeq = "0" + binarySeq
	return binarySeq


def binarytoHex(binarySeq):
	Hex = ""
	for i in range(8):
		Hex += b2Hex[binarySeq[4*i:4*i+4]]
	return Hex

def convert(string):
	contents = string.split(" ")
	instBinarySeq = ""
	try:
		instBinarySeq += Inst2OpCode[contents[0]]
	except KeyError:
		print "Invalid Command."
		return None

	if len(contents) == 3:
		# PrMem Command
		if contents[0] == "PRMEM":
			try:
				assert contents[1][0] == 'R'
				registerNo = int(contents[1][1:])
				if registerNo > 65535 and registerNo < 0:
					print "Invalid Register No."
					return None
			except AssertionError as e:
				print "Register name should be written as R<register no>"
				return None
			except ValueError as e:
				print "Invalid Register No."
				return None
			instBinarySeq += binaryConvert(registerNo)
			try:
				no = int(contents[2])
				if no > 65535:							#16-bit no? Signed or Unsigned : Put 65535 for unsigned and 32767 for Signed. Put Lower bound also for Signed.
					print "Not a valid 16-bit No."
					return None
			except ValueError:
				print "Invalid 16-bit Number"
				return None
			instBinarySeq += "00000"
			instBinarySeq += binaryConvert(no, 1)
			return binarytoHex(instBinarySeq)
		else:
			print "Invalid Command"
			return None


	elif len(contents) == 4:
		# ADD, SUB, SLT, AND, OR Commands
		if Inst2OpCode[contents[0]] == "000000":
			try: 
				Fuct = Inst2Fuct[contents[0]]
				
				assert contents[1][0] == 'R'
				registerNo = int(contents[1][1:])

				assert contents[2][0] == 'R'
				registerNo2 = int(contents[2][1:])

				assert contents[3][0] == 'R'
				registerNo3 = int(contents[3][1:])

				if registerNo > 31 or registerNo < 0 or registerNo2 > 31 or registerNo2 < 0 or registerNo3 > 31 or registerNo3 < 0:
					print "Invalid Register No."
					return None

			except KeyError:
				print "Invalid Command"
				return None
			except AssertionError as e:
				print "Register name should be written as R<register no>"
				return None
			except ValueError as e:
				print "Invalid Register No."
				return None

			instBinarySeq += binaryConvert(registerNo)
			instBinarySeq += binaryConvert(registerNo2)
			instBinarySeq += binaryConvert(registerNo3)
			instBinarySeq += "00000"
			instBinarySeq += Fuct
			return binarytoHex(instBinarySeq)

		if contents[0] in ["LW", "SW", "BEQ", "ADDI"]:
			try:
				assert contents[1][0] == 'R'
				registerNo = int(contents[1][1:])
				assert contents[2][0] == 'R'
				registerNo2 = int(contents[2][1:])
				if registerNo > 31 or registerNo < 0 or registerNo2 > 31 or registerNo2 < 0:
					print "Invalid Register No."
					return None

			except KeyError:
				print "Invalid Command"
				return None
			except AssertionError as e:
				print "Register name should be written as R<register no>"
				return None
			except ValueError as e:
				print "Invalid Register No."
				return None
			try:
				no = int(contents[3])
				if no > 65535:							#16-bit no? Signed or Unsigned : Put 65535 for unsigned and 32767 for Signed. Put Lower bound also for Signed.
					print "Not a valid 16-bit No."
					return None
			except ValueError:
				print "Invalid 16-bit Number"
				return None
			instBinarySeq += binaryConvert(registerNo)
			instBinarySeq += binaryConvert(registerNo2)
			instBinarySeq += binaryConvert(no, 1)
			return binarytoHex(instBinarySeq)
		print "Invalid Command"
		return None


	elif len(contents) == 2:
		if contents[0] == "JUMP":
			try:
				no = int(contents[1])
				if no > 65535:							#16-bit no? Signed or Unsigned : Put 65535 for unsigned and 32767 for Signed. Put Lower bound also for Signed.
					print "Not a valid 16-bit No."
					return None
			except ValueError:
				print "Invalid 16-bit Number"
				return None
			instBinarySeq += "00000"
			instBinarySeq += "00000"
			instBinarySeq += binaryConvert(no, 1)
		elif contents[0] == "PRREG":
			try:
				assert contents[1][0] == 'R'
				registerNo = int(contents[1][1:])
				if registerNo > 31 or registerNo < 0:
					print "Invalid Register No."
					return None
			except AssertionError as e:
				print "Register name should be written as R<register no>"
				return None
			except ValueError as e:
				print "Invalid Register No."
				return None
			instBinarySeq += binaryConvert(registerNo)
			instBinarySeq += "00000"
			instBinarySeq += "0000000000000000"
		else:
			print "Invalid Command"
			return None
		return binarytoHex(instBinarySeq)
		

	else:
		print "Invalid Instruction."
		return None


string = []
print "Start writing Program.\nTo see available Instructions and formats, please refer to Documentation\nTo create ModelSim Script of your program, enter Load as Input.\n"
inputString = ""
while inputString != "LOAD":
	inputString = raw_input(">> ").upper()
	commandLine = convert(inputString)
	if commandLine == None:
		continue;
	string.append(commandLine)
print "\n".join(string)

while not access('Scripts/', 2):
	print "Make sure Scripts/ folder exists and you have write access."
	inp = raw_input("Enter '1' to Try Again\n      '0' to exit without saving.\n")
	if inp == '0':
		break;
	elif inp == '1':
		continue;
	else:
		print "Invalid Entry"

chdir('Scripts/')
Filename = raw_input("Enter Name of Script File (without extension): ")
# while not access(Filename+".fdo", 1) or Filename.lower() != "exit":
# 	print "Can not open/write this file.\n "
# 	Filename = raw_input("Reenter Name of Script File (without extension): \nWrite 'Exit' to exit without saving.\n>>")
# if Filename.lower() != "exit":
if access(Filename+".fdo", 0):
	print "File already exist. Program will overwrite its contents."
f = file(Filename+".fdo", 'w')
fileContents = 'vlib work\nvcom -explicit  -93 "../src/SX.vhd"\nvcom -explicit  -93 "../src/REG_32x32.vhd"\nvcom -explicit  -93 "../src/PC.vhd"\nvcom -explicit  -93 "../src/Memory.vhd"\nvcom -explicit  -93 "../src/IR.vhd"\nvcom -explicit  -93 "../src/ControlUnit.vhd"\nvcom -explicit  -93 "../src/ALU.vhd"\nvcom -explicit  -93 "../src/ADDER.vhd"\nvcom -explicit  -93 "../src/OutputUnit.vhd"\nvcom -explicit  -93 "../src/TOP_MODULE.vhd"\nvsim -t 1ps   -lib work TOP_MODULE\ndo {../src/TOP_MODULE.udo}\nview wave\nadd wave *\nview structure\nview signals\nrun 1000ns\n\nforce -freeze sim:/top_module/CLK 1 0, 0 {50 ps} -r 100\nforce -freeze sim:/top_module/InstWrite 1 0'
print str(len(string))
for i in range(len(string)):
	fileContents += "\nforce -freeze sim:/top_module/InstIn 32'h"+string[i]+" 0\nrun\nrun\nrun\n"
	if i == 0:
		fileContents += "run\n"
f.write(fileContents+"\nforce -freeze sim:/top_module/InstWrite 0 0\n")
f.close()
print "Script is saved in Scripts/"+Filename+".fdo\nOpen ModelSim and run the script using `do "+Filename+".fdo`\n"

# print "You program is discarded."