#! /usr/bin/python
from sys import stdin, stdout

started=False
preParagraph=False
inParagraph=False
inSpeech=False
for line in stdin.readlines():
	#Dialogue blocks
	if line[0] == ':':
		#Reached a new block so close old ones and open new ones
		if not started:
			started = True
			stdout.write('<div class="dialog">')
		else:
			preParagraph=False
			if inParagraph:
				stdout.write('</p>')
				inParagraph=False
			if inSpeech:
				stdout.write('</span>')
				inSpeech=False
			stdout.write('</div>\n<div class="dialog">')
		#everything (except for the first colon) to the left of the second colon
		#or the whole thing if there is only one goes on the left
		parts = line[1:-1].split(':',1)
		stdout.write('<span class="name">%s:</span>' % (parts[0]))
		stdout.write('<span class="speech">')
		if len(parts) > 1:
			stdout.write(parts[1])
		inSpeech=True
	elif line[0] == '>':
		#Similar close/open 
		if not started:
			started=True
			stdout.write('<div class="action">')
		else:
			preParagraph=False
			if inParagraph:
				stdout.write('</p>')
				inParagraph=False
			if inSpeech:
				stdout.write('</span>')
				inSpeech=False
			stdout.write('</div>\n<div class="action">')
		stdout.write(line[1:])

	elif line == '\n':
		if not preParagraph:
			#force a requirement for a newline before we can make paragraphs
			preParagraph = True
		elif inParagraph:
			#if already in one, close the old one
			#pre-paragraph stays on since this is the midpoint
			stdout.write('</p>')
			inParagraph=False
	else:
		if preParagraph and not inParagraph:
			stdout.write('<p>')
			inParagraph=True
		stdout.write(line)

#Close everything up
if inParagraph:
	stdout.write('</p>')
if inSpeech:
	stdout.write('</span>')
stdout.write('</div>')