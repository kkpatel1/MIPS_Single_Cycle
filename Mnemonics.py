import os

Inst2OpCode = { 'LW' : '100011',
				'SW' : '101011',
				'BEQ' : '000100',
				'JUMP' : '000101',
				'ADDI' : '001000',
				'PrReg' : '111111',
				'PrMem' : '111110',
				'ADD' : '000000',
				'SUB' : '000000',
				'AND' : '000000',
				'OR' : '000000',
				'SLT' : '000000' }

Inst2Fuct = { 'ADD' : '000000', 'SUB' : '000001', 'AND' : '000010', 'OR' : '000011', 'SLT' : '000100' }

def binaryConvert(no):

def convert(string):
	contents = string.split(" ")
	instBinarySeq = ""
	try:
		instBinarySeq += Inst2OpCode[contents[0]]
	except KeyError:
		print "Invalid Command."
		return None

	if len(contents) = 3:
		# PrMem Command
		try:
			ASSERT contents[1][0] == 'R'
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
		instBinarySeq += binaryConvert(no)
		return instBinarySeq


	elif len(contents) = 5:
		# ADD, SUB, SLT, AND, OR Commands
		try: 
			Fuct = Inst2Fuct[contents[0]]
			
			ASSERT contents[1][0] == 'R'
			registerNo = int(contents[1][1:])

			ASSERT contents[2][0] == 'R'
			registerNo2 = int(contents[2][1:])

			ASSERT contents[3][0] == 'R'
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
		return instBinarySeq

	elif len(contents) = 2:
		if contents[0] = "JUMP":
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
			instBinarySeq += binaryConvert(no)
		elif contents[0] = "PrReg":
			try:
				ASSERT contents[1][0] == 'R'
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








string = []
print "Start writing Program.\nTo see available Instructions and formats, please refer to Documentation\nTo create ModelSim Script of your program, enter Load as Input."
inputString = raw_input("Start writing Program. To see available Instructions and formats, please refer to Documentation.")
while inputString != "Load":
	commandLine = convert(inputString)
	if commandLine == None:
		continue;