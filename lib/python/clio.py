"""
Clio: A toolkit for creating elegant command line interfaces.

Author: Darren Mulholland <dmulholland@outlook.ie>
License: Public Domain

"""

import sys


# Library version number.
__version__ = "0.1.3"


# Internal class for storing option data.
class Option:

    def __init__(self, type, value):
        self.type = type
        self.value = value


# Internal class for making a list of arguments available as a stream.
class ArgStream:

    def __init__(self, args):
        self.args = list(args)
        self.length = len(self.args)
        self.index = 0

    # Returns true if the stream contains another argument.
    def has_next(self):
        return self.index < self.length

    # Returns the next argument from the stream.
    def next(self):
        self.index += 1
        return self.args[self.index - 1]

    # Returns the next argument from the stream without consuming it.
    def peek(self):
        return self.args[self.index]

    # Returns a list containing all the remaining arguments from the stream.
    def remainder(self):
        return self.args[self.index:]


# ArgParser is the workhorse class of the toolkit. An ArgParser instance is
# responsible for registering options and parsing the input array of raw
# arguments. Note that every registered command recursively receives an
# ArgParser instance of its own. In theory commands can be stacked to any depth,
# although in practice even two levels is confusing for users and best avoided.
class ArgParser:

    # Specifying a string of help text activates the automatic --help flag.
    # Specifying a version string activates the automatic --version flag.
    def __init__(self, helptext=None, version=None):

        # Command line help text for the application or command.
        self.helptext = helptext.strip()

        # Application version number as a string.
        self.version = version

        # Stores option objects indexed by option name.
        self.options = {}

        # Storew option objects indexed by single-letter shortcut.
        self.shortcuts = {}

        # Stores command sub-parser instances indexed by command.
        self.commands = {}

        # Stores command callbacks indexed by command.
        self.callbacks = {}

        # Stores positional arguments parsed from the input stream.
        self.arguments = []

    # Register an option on the parser instance.
    def _add_option(self, type, name, default, shortcut):
        option = Option(type, default)
        self.options[name] = option
        if shortcut is not None:
            self.shortcuts[shortcut] = option

    # Register a flag, optionally specifying a single-letter shortcut.
    def add_flag(self, name, shortcut=None):
        self._add_option("flag", name, False, shortcut)

    # Register a string option, optionally specifying a single-letter shortcut.
    def add_str_option(self, name, default, shortcut=None):
        self._add_option("string", name, default, shortcut)

    # Register an integer option, optionally specifying a single-letter shortcut.
    def add_int_option(self, name, default, shortcut=None):
        self._add_option("int", name, default, shortcut)

    # Register a float option, optionally specifying a single-letter shortcut.
    def add_float_option(self, name, default, shortcut=None):
        self._add_option("float", name, default, shortcut)

    # Register a command and its associated callback.
    def add_command(self, command, callback, helptext):
        parser = ArgParser(helptext)
        self.commands[command] = parser
        self.callbacks[command] = callback
        return parser

    # Print the parser's help text and exit.
    def help(self):
        sys.stdout.write(self.helptext + "\n")
        sys.exit()

    # Parse a list of arguments.
    def parse(self, args=sys.argv[1:]):

        # Switch to turn off option parsing if we encounter a -- argument.
        # Subsequent arguments beginning with a dash will be treated as
        # positional arguments instead of options.
        parsing_options = True

        # Convert the input list into a stream.
        argstream = ArgStream(args)

        # Loop while we have arguments to process.
        while argstream.has_next():

            # If we encounter a -- argument, turn off option parsing.
            if parsing_options and argstream.peek() == "--":
                argstream.next()
                parsing_options = False

            # Is the argument a long-form option or flag?
            elif parsing_options and argstream.peek().startswith("--"):
                argstring = argstream.next()[2:]

                # Is the argument a registered option name?
                if argstring in self.options:
                    option = self.options[argstring]

                    # If the option is a flag, store the boolean true.
                    if option.type == "flag":
                        option.value = True

                    # Otherwise, check for a following argument.
                    elif argstream.has_next():
                        nextarg = argstream.next()

                        if option.type == "string":
                            option.value = nextarg

                        elif option.type == "int":
                            try:
                                option.value = int(nextarg)
                            except ValueError:
                                sys.exit("Error: cannot parse '%s' as an integer." % nextarg)

                        elif option.type == "float":
                            try:
                                option.value = float(nextarg)
                            except ValueError:
                                sys.exit("Error: cannot parse '%s' as a float." % nextarg)

                    # No following argument, so print an error and exit.
                    else:
                        sys.exit("Error: missing argument for the --%s option" % argstring)

                # Is the argument the automatic --help flag?
                elif argstring == "help" and self.helptext is not None:
                    sys.stdout.write(self.helptext + "\n")
                    sys.exit()

                # Is the argument the automatic --version flag?
                elif argstring == "version" and self.version is not None:
                    sys.stdout.write(self.version + "\n")
                    sys.exit()

                # The argument is not a registered or automatic option.
                # Print an error message and exit.
                else:
                    sys.exit("Error: --%s is not a recognised option." % argstring)

            # Is the argument a short-form option or flag?
            elif parsing_options and argstream.peek().startswith("-"):
                argstring = argstream.next()

                # If the argument consists of a single dash or a dash followed
                # by a digit, treat it as a free argument.
                if argstring == '-' or argstring[1].isdigit():
                    self.arguments.append(argstring)
                    continue

                # Examine each character individually to allow for condensed
                # short-form arguments, i.e.
                #     -a -b foo -c bar
                # is equivalent to:
                #     -abc foo bar
                for c in argstring[1:]:

                    # Is the character a registered shortcut?
                    if c in self.shortcuts:
                        option = self.shortcuts[c]

                        # If the option is a flag, store the boolean true.
                        if option.type == "flag":
                            option.value = True

                        # Otherwise, check for a following argument.
                        elif argstream.has_next():
                            nextarg = argstream.next()

                            if option.type == "string":
                                option.value = nextarg

                            elif option.type == "int":
                                try:
                                    option.value = int(nextarg)
                                except ValueError:
                                    sys.exit("Error: cannot parse '%s' as an integer." % nextarg)

                            elif option.type == "float":
                                try:
                                    option.value = float(nextarg)
                                except ValueError:
                                    sys.exit("Error: cannot parse '%s' as a float." % nextarg)

                        # No following argument, so print an error and exit.
                        else:
                            sys.exit("Error: missing argument for the -%s option." % c)

                    # Not a recognised shortcut. Print an error and exit.
                    else:
                        sys.exit("Error: -%s is not a recognised option." % c)

            # Is the argument a registered command?
            elif argstream.peek() in self.commands:
                command = argstream.next()
                parser = self.commands[command]
                callback = self.callbacks[command]
                argset = parser.parse(argstream.remainder())
                callback(argset)
                return ArgSet(self.options, self.arguments, command, argset)

            # Is the argument the automatic 'help' command?
            elif argstream.peek() == "help":
                argstream.next()
                if argstream.has_next():
                    command = argstream.next()
                    if command in self.commands:
                        sys.stdout.write(self.commands[command].helptext + "\n")
                        sys.exit()
                    else:
                        sys.exit("Error: '%s' is not a recognised command." % command)
                else:
                    sys.exit("Error: the help command requires an argument.")

            # Otherwise, add the argument to our list of free arguments.
            else:
                self.arguments.append(argstream.next())

        return ArgSet(self.options, self.arguments)


# An ArgSet instance represents a set of parsed arguments.
class ArgSet:

    def __init__(self, options, arguments, command=None, argset=None):

        # Stores a dictionary of option objects indexed by option name.
        self.options = options

        # Stores a list of positional arguments.
        self.arguments = arguments

        # Stores the command string, if a command was found.
        self.command = command

        # Stores the command's ArgSet instance, if a command was found.
        self.argset = argset

    # Enable dictionary-style access to options: value = argset['name'].
    def __getitem__(self, name):
        return self.options[name].value

    # Enable dictionary-style assignment: argset['name'] = value.
    def __setitem__(self, name, value):
        self.options[name] = Option("unknown", value)

    # List all options and arguments for debugging.
    def __str__(self):
        lines = []

        lines.append("Options:")
        if len(self.options):
            for name in sorted(self.options):
                lines.append("  %s: %s" % (name, self.options[name].value))
        else:
            lines.append("  [none]")

        lines.append("\nArguments:")
        if len(self.arguments):
            for arg in self.arguments:
                lines.append("  %s" % arg)
        else:
            lines.append("  [none]")

        lines.append("\nCommand:")
        if self.has_cmd():
            lines.append("  %s" % self.get_cmd())
        else:
            lines.append("  [none]")

        return "\n".join(lines)

    # Returns the value of the specified option.
    def get_option(self, name):
        return self.options[name].value

    # Returns a dictionary containing all the set's named options.
    def get_options(self):
        return {name: option.value for name, option in self.options.items()}

    # Returns true if the set contains at least one positional argument.
    def has_args(self):
        return len(self.arguments > 0)

    # Returns a list of the set's positional arguments.
    def get_args(self):
        return self.arguments

    # Convenience function: attemps to parse and return the set's positional
    # arguments as a list of integers.
    def get_args_as_ints(self):
        args = []
        for arg in self.arguments:
            try:
                args.append(int(arg))
            except ValueError:
                sys.exit("Error: cannot parse '%s' as an integer." % arg)
        return args

    # Convenience function: attemps to parse and return the set's positional
    # arguments as a list of floats.
    def get_args_as_floats(self):
        args = []
        for arg in self.arguments:
            try:
                args.append(float(arg))
            except ValueError:
                sys.exit("Error: cannot parse '%s' as a float." % arg)
        return args

    # Returns true if the set contains a command.
    def has_cmd(self):
        return self.command is not None

    # Returns the set's command string, if a command was found.
    def get_cmd(self):
        return self.command

    # Returns the ArgSet instance for the set's command, if a command was found.
    def get_cmd_argset(self):
        return self.argset
