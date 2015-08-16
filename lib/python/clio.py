"""
Clio: A toolkit for creating elegant command line interfaces.

Author: Darren Mulholland <dmulholland@outlook.ie>
License: Public Domain

"""

import sys


# Library version number.
__version__ = "0.2.0"


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
        self.helptext = helptext.strip() if helptext else None

        # Application version number as a string.
        self.version = version.strip() if version else None

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

        # Stores the command string, if a command is found while parsing.
        self.command = None

        # Stores the command's parser instance, if a command is found.
        self.command_parser = None

    # Enable dictionary-style access to options: value = parser['name'].
    def __getitem__(self, name):
        return self.options[name].value

    # Enable dictionary-style assignment to options: parser['name'] = value.
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

    # Parse a list of string arguments.
    def parse(self, args=sys.argv[1:]):

        # Switch to turn off parsing if we encounter a -- argument.
        # Everything following the -- will be treated as a positional
        # argument.
        parsing = True

        # Convert the input list into a stream.
        stream = ArgStream(args)

        # Loop while we have arguments to process.
        while stream.has_next():

            # Fetch the next argument from the stream.
            arg = stream.next()

            # If parsing has been turned off, simply add the argument to the
            # list of positionals.
            if not parsing:
                self.arguments.append(arg)
                continue

            # If we encounter a -- argument, turn off parsing.
            if arg == "--":
                parsing = False
                continue

            # Is the argument a long-form option or flag?
            if arg.startswith("--"):

                # Strip the prefix.
                arg = arg[2:]

                # Is the argument a registered option name?
                if arg in self.options:
                    option = self.options[arg]

                    # If the option is a flag, store the boolean true.
                    if option.type == "flag":
                        option.value = True

                    # Otherwise, check for a following argument.
                    elif stream.has_next():
                        nextarg = stream.next()

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
                        sys.exit("Error: missing argument for the --%s option." % arg)

                # Is the argument the automatic --help flag?
                elif arg == "help" and self.helptext is not None:
                    sys.stdout.write(self.helptext + "\n")
                    sys.exit()

                # Is the argument the automatic --version flag?
                elif arg == "version" and self.version is not None:
                    sys.stdout.write(self.version + "\n")
                    sys.exit()

                # The argument is not a registered or automatic option.
                # Print an error message and exit.
                else:
                    sys.exit("Error: --%s is not a recognised option." % arg)

            # Is the argument a short-form option or flag?
            elif arg.startswith("-"):

                # If the argument consists of a single dash or a dash followed
                # by a digit, treat it as a free argument.
                if arg == '-' or arg[1].isdigit():
                    self.arguments.append(arg)
                    continue

                # Examine each character individually to allow for condensed
                # short-form arguments, i.e.
                #     -a -b foo -c bar
                # is equivalent to:
                #     -abc foo bar
                for c in arg[1:]:

                    # Is the character a registered shortcut?
                    if c in self.shortcuts:
                        option = self.shortcuts[c]

                        # If the option is a flag, store the boolean true.
                        if option.type == "flag":
                            option.value = True

                        # Otherwise, check for a following argument.
                        elif stream.has_next():
                            nextarg = stream.next()

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
            elif arg in self.commands:
                cmd_parser = self.commands[arg]
                cmd_callback = self.callbacks[arg]
                cmd_parser.parse(stream.remainder())
                cmd_callback(cmd_parser)
                self.command = arg
                self.command_parser = cmd_parser
                break

            # Is the argument the automatic 'help' command?
            elif arg == "help":
                if stream.has_next():
                    command = stream.next()
                    if command in self.commands:
                        sys.stdout.write(self.commands[command].helptext + "\n")
                        sys.exit()
                    else:
                        sys.exit("Error: '%s' is not a recognised command." % command)
                else:
                    sys.exit("Error: the help command requires an argument.")

            # Otherwise, add the argument to our list of free arguments.
            else:
                self.arguments.append(arg)

    # Returns the value of the specified option.
    def get_option(self, name):
        return self.options[name].value

    # Returns a dictionary containing all the named options.
    def get_options(self):
        return {name: option.value for name, option in self.options.items()}

    # Returns true if at least one positional argument was found.
    def has_args(self):
        return len(self.arguments > 0)

    # Returns the positional arguments as a list of strings.
    def get_args(self):
        return self.arguments

    # Convenience function: attempts to parse and return the positional
    # arguments as a list of integers.
    def get_args_as_ints(self):
        args = []
        for arg in self.arguments:
            try:
                args.append(int(arg))
            except ValueError:
                sys.exit("Error: cannot parse '%s' as an integer." % arg)
        return args

    # Convenience function: attempts to parse and return the positional
    # arguments as a list of floats.
    def get_args_as_floats(self):
        args = []
        for arg in self.arguments:
            try:
                args.append(float(arg))
            except ValueError:
                sys.exit("Error: cannot parse '%s' as a float." % arg)
        return args

    # Returns true if the parser has found a registered command.
    def has_cmd(self):
        return self.command is not None

    # Returns the command string, if a command was found.
    def get_cmd(self):
        return self.command

    # Returns the command's parser instance, if a command was found.
    def get_cmd_parser(self):
        return self.command_parser
