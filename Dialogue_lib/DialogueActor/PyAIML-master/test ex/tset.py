import sys
sys.path.insert(0, "../")

import aiml

# The Kernel object is the public interface to
# the AIML interpreter.
k = aiml.Kernel()

# Use the 'learn' method to load the contents
# of an AIML file into the Kernel.
k.learn("test.xml")

# Use the 'respond' method to compute the response
# to a user's input string.  respond() returns
# the interpreter's response, which in this case
# we ignore.
k.respond("load aiml cn")

# Loop forever, reading user input from the command
# line and printing responses.
while True: print k.respond(raw_input("> "))
