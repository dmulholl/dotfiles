# --------------------------------------------------------------------------
# Clio: a minimalist argument-parsing library designed for building elegant
# command line interfaces.
#
# Author: Darren Mulholland <darren@mulholland.xyz>
# License: Public Domain
# --------------------------------------------------------------------------

import sys


# Library version number.
__version__ = "2.0.3"


# Print a message to stderr and exit with a non-zero error code.
def err(msg):
    sys.exit("Error: %s." % msg)


# Exception raised when an invalid API call is attempted. (Invalid user input
# does not raise an exception; instead the application exits with an error
# message.)
class ArgParserError(Exception):
    pass


# Internal class for storing option data.
#  * Option type is one of 'bool', 'string', 'int', or 'float'.
#  * A 'greedy' list option attempts to parse multiple consecutive arguments.
class Option:

    def __init__(self, type):
        self.type = type
        self.found = False
        self.greedy = False
        self.values = []

    # Appends a value to the option's internal list.
    def append(self, value):
        self.values.append(value)

    # Clears the option's internal list of values.
    def clear(self):
        self.values.clear()

    # Returns the last value from the option's internal list.
    @property
    def value(self):
        return self.values[-1]


# Internal class for making a list of arguments available as a stream.
class ArgStream:

    def __init__(self, args):
        self.args = list(args)
        self.length = len(self.args)
        self.index = 0

    # Returns the next argument from the stream.
    def next(self):
        self.index += 1
        return self.args[self.index - 1]

    # Returns the next argument from the stream without consuming it.
    def peek(self):
        return self.args[self.index]

    # Returns true if the stream contains at least one more element.
    def has_next(self):
        return self.index < self.length

    # Returns true if the stream contains at least one more element and that
    # element has the form of an option value.
    def has_next_value(self):
        if self.has_next():
            arg = self.peek()
            if arg.startswith('-'):
                if arg == '-' or arg[1].isdigit():
                    return True
                else:
                    return False
            else:
                return True
        return False


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

        # Stores Option instances indexed by name.
        self.options = {}

        # Stores command sub-parser instances indexed by command name.
        self.commands = {}

        # Stores command callbacks indexed by command name.
        self.callbacks = {}

        # Stores positional arguments parsed from the input stream.
        self.arguments = []

        # Stores the command name, if a command was found while parsing.
        self.cmd_name = None

        # Stores the command's parser instance, if a command was found.
        self.cmd_parser = None

        # Stores a reference to a command parser's parent parser.
        self.parent = None

    # Enable dictionary/list-style access to options and arguments.
    def __getitem__(self, key):
        if isinstance(key, int) or isinstance(key, slice):
            return self.arguments[key]
        else:
            option = self._get_opt(key)
            return option.value

    # List all options and arguments for debugging.
    def __str__(self):
        lines = []

        lines.append("Options:")
        if len(self.options):
            for name, option in sorted(self.options.items()):
                lines.append("  %s: %s" % (name, option.values))
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
            lines.append("  %s" % self.get_cmd_name())
        else:
            lines.append("  [none]")

        return "\n".join(lines)

    # Print the parser's help text and exit.
    def help(self):
        sys.stdout.write(self.helptext + "\n")
        sys.exit()

    # ----------------------------------------------------------------------
    # Registering options.
    # ----------------------------------------------------------------------

    # Register an option with a default value.
    def _add_opt(self, type, name, default):
        option = Option(type)
        option.append(default)
        for alias in name.split():
            self.options[alias] = option

    # Register a boolean option with a default value of false.
    def add_flag(self, name):
        self._add_opt("bool", name, False)

    # Register a string option with a default value.
    def add_str(self, name, default):
        self._add_opt("string", name, default)

    # Register an integer option with a default value.
    def add_int(self, name, default):
        self._add_opt("int", name, default)

    # Register a float option with a default value.
    def add_float(self, name, default):
        self._add_opt("float", name, default)

    # Register a list option.
    def _add_list_opt(self, type, name, greedy):
        option = Option(type)
        option.greedy = greedy
        for alias in name.split():
            self.options[alias] = option

    # Register a boolean list option.
    def add_flag_list(self, name):
        self._add_list_opt("bool", name, False)

    # Register a string list option.
    def add_str_list(self, name, greedy=False):
        self._add_list_opt("string", name, greedy)

    # Register an integer list option.
    def add_int_list(self, name, greedy=False):
        self._add_list_opt("int", name, greedy)

    # Register a float list option.
    def add_float_list(self, name, greedy=False):
        self._add_list_opt("float", name, greedy)

    # ----------------------------------------------------------------------
    # Retrieving options.
    # ----------------------------------------------------------------------

    # Returns true if the specified option was found while parsing.
    def found(self, name):
        option = self._get_opt(name)
        return option.found

    # Returns the specified Option instance or raises an exception.
    def _get_opt(self, name):
        option = self.options.get(name)
        if option:
            return option
        else:
            raise ArgParserError("'%s' is not a registered option" % name)

    # Returns the value of the specified option.
    def get_flag(self, name):
        return self._get_opt(name).value

    # Returns the value of the specified option.
    def get_str(self, name):
        return self._get_opt(name).value

    # Returns the value of the specified option.
    def get_int(self, name):
        return self._get_opt(name).value

    # Returns the value of the specified option.
    def get_float(self, name):
        return self._get_opt(name).value

    # Returns the length of the specified option's list of values.
    def len_list(self, name):
        return len(self._get_opt(name).values)

    # Returns the values of the specified list-option.
    def get_flag_list(self, name):
        return self._get_opt(name).values

    # Returns the values of the specified list-option.
    def get_str_list(self, name):
        return self._get_opt(name).values

    # Returns the values of the specified list-option.
    def get_int_list(self, name):
        return self._get_opt(name).values

    # Returns the values of the specified list-option.
    def get_float_list(self, name):
        return self._get_opt(name).values

    # ----------------------------------------------------------------------
    # Setting options.
    # ----------------------------------------------------------------------

    # Clear the specified option's internal list of values.
    def clear_list(self, name):
        option = self._get_opt(name)
        option.clear()

    # Append a value to the specified option's internal list.
    def _set_opt(self, name, value):
        option = self._get_opt(name)
        option.append(value)

    # Append a value to the specified option's internal list.
    def set_flag(self, name, value):
        option = self._get_opt(name)
        option.append(value)

    # Append a value to the specified option's internal list.
    def set_str(self, name, value):
        option = self._get_opt(name)
        option.append(value)

    # Append a value to the specified option's internal list.
    def set_int(self, name, value):
        option = self._get_opt(name)
        option.append(value)

    # Append a value to the specified option's internal list.
    def set_float(self, name, value):
        option = self._get_opt(name)
        option.append(value)

    # ----------------------------------------------------------------------
    # Commands.
    # ----------------------------------------------------------------------

    # Register a command and its associated callback.
    def add_cmd(self, name, helptext, callback):
        parser = ArgParser(helptext)
        parser.parent = self
        for alias in name.split():
            self.commands[alias] = parser
            self.callbacks[alias] = callback
        return parser

    # Returns true if the parser has found a registered command.
    def has_cmd(self):
        return self.cmd_name is not None

    # Returns the command name, if the parser has found a command.
    def get_cmd_name(self):
        return self.cmd_name

    # Returns the command's parser instance, if the parser has found a command.
    def get_cmd_parser(self):
        return self.cmd_parser

    # Returns a command parser's parent parser.
    def get_parent(self):
        return self.parent

    # ----------------------------------------------------------------------
    # Positional arguments.
    # ----------------------------------------------------------------------

    # Returns true if at least one positional argument has been found.
    def has_args(self):
        return len(self.arguments) > 0

    # Returns the length of the positional argument list.
    def len_args(self):
        return len(self.arguments)

    # Returns the positional argument at the specified index.
    def get_arg(self, index):
        return self.arguments[index]

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
                err("cannot parse '%s' as an integer" % arg)
        return args

    # Convenience function: attempts to parse and return the positional
    # arguments as a list of floats.
    def get_args_as_floats(self):
        args = []
        for arg in self.arguments:
            try:
                args.append(float(arg))
            except ValueError:
                err("cannot parse '%s' as a float" % arg)
        return args

    # ----------------------------------------------------------------------
    # Parsing arguments.
    # ----------------------------------------------------------------------

    # Parse a list of string arguments. We default to parsing the command
    # line arguments, skipping the application path.
    def parse(self, args=sys.argv[1:]):
        self.parse_stream(ArgStream(args))

    # Parse a stream of string arguments.
    def parse_stream(self, stream):

        # Switch to turn off option parsing if we encounter a double dash,
        # '--'. Everything following the '--' will be treated as a positional
        # argument.
        parsing = True

        # Loop while we have arguments to process.
        while stream.has_next():

            # Fetch the next argument from the stream.
            arg = stream.next()

            # If option parsing has been turned off, simply add the argument to
            # the list of positionals.
            if not parsing:
                self.arguments.append(arg)
                continue

            # If we encounter a '--' argument, turn off option-parsing.
            if arg == "--":
                parsing = False

            # Is the argument a long-form option?
            elif arg.startswith("--"):
                self._parse_long_opt(arg[2:], stream)

            # Is the argument a short-form option? If the argument consists of
            # a single dash or a dash followed by a digit, we treat it as a
            # positional argument.
            elif arg.startswith("-"):
                if arg == '-' or arg[1].isdigit():
                    self.arguments.append(arg)
                else:
                    self._parse_short_opt(arg[1:], stream)

            # Is the argument a registered command?
            elif arg in self.commands:
                cmd_parser = self.commands[arg]
                cmd_callback = self.callbacks[arg]
                self.cmd_name = arg
                self.cmd_parser = cmd_parser
                cmd_parser.parse_stream(stream)
                cmd_callback(cmd_parser)

            # Is the argument the automatic 'help' command?
            elif arg == "help":
                if stream.has_next():
                    name = stream.next()
                    if name in self.commands:
                        sys.stdout.write(self.commands[name].helptext + "\n")
                        sys.exit()
                    else:
                        err("'%s' is not a recognised command" % name)
                else:
                    err("the help command requires an argument")

            # Otherwise, add the argument to our list of positional arguments.
            else:
                self.arguments.append(arg)

    # Attempt to parse the specified argument as a string, integer, or float.
    # (Parsing as a string is a null operation.)
    def _try_parse_arg(self, argtype, arg):
        if argtype == "string":
            return arg
        elif argtype == "int":
            try:
                return int(arg)
            except ValueError:
                err("cannot parse '%s' as an integer" % arg)
        elif argtype == "float":
            try:
                return float(arg)
            except ValueError:
                err("cannot parse '%s' as a float" % arg)
        else:
            raise ArgParserError("invalid option type '%s'" % argtype)

    # Parse an option of the form --name=value or -n=value.
    def _parse_equals_opt(self, prefix, arg):
        name, value = arg.split("=", maxsplit=1)

        # Is the argument a registered option name?
        option = self.options.get(name)
        if not option:
            err("%s%s is not a recognised option" % (prefix, name))
        option.found = True

        # Invalid format for a boolean flag.
        if option.type == "bool":
            err("invalid format for boolean flag %s%s" % (prefix, name))

        # Make sure we have a value after the equals sign.
        if not value:
            err("missing argument for the %s%s option" % (prefix, name))

        # Try to parse the argument as a value of the appropriate type.
        self._set_opt(name, self._try_parse_arg(option.type, value))

    # Parse a long-form option, i.e. an option beginning with a double dash.
    def _parse_long_opt(self, arg, stream):

        # Do we have an option of the form --name=value?
        if "=" in arg:
            self._parse_equals_opt("--", arg)

        # Is the argument a registered option name?
        elif arg in self.options:
            option = self.options[arg]
            option.found = True

            # If the option is a flag, store the boolean true.
            if option.type == "bool":
                self.set_flag(arg, True)

            # Check for a following option value.
            elif stream.has_next_value():

                # Try to parse the argument as a value of the appropriate type.
                value = self._try_parse_arg(option.type, stream.next())
                self._set_opt(arg, value)

                # If the option is a greedy list, keep trying to parse values
                # until we hit the next option or the end of the stream.
                if option.greedy:
                    while stream.has_next_value():
                        value = self._try_parse_arg(option.type, stream.next())
                        self._set_opt(arg, value)

            # We're missing a required option value.
            else:
                err("missing argument for the --%s option" % arg)

        # Is the argument the automatic --help flag?
        elif arg == "help" and self.helptext is not None:
            sys.stdout.write(self.helptext + "\n")
            sys.exit()

        # Is the argument the automatic --version flag?
        elif arg == "version" and self.version is not None:
            sys.stdout.write(self.version + "\n")
            sys.exit()

        # The argument is not a registered or automatic option name.
        # Print an error message and exit.
        else:
            err("--%s is not a recognised option" % arg)

    # Parse a short-form option, i.e. an option beginning with a single dash.
    def _parse_short_opt(self, arg, stream):

        # Do we have an option of the form -n=value?
        if "=" in arg:
            self._parse_equals_opt("-", arg)
            return

        # We handle each character individually to support condensed options:
        #   -abc foo bar
        # is equivalent to:
        #   -a foo -b bar -c
        for char in arg:
            option = self.options.get(char)
            if not option:
                err("-%s is not a recognised option" % char)
            option.found = True

            # If the option is a flag, store the boolean true.
            if option.type == "bool":
                self.set_flag(char, True)

            # Check for a following option value.
            elif stream.has_next_value():

                # Try to parse the argument as a value of the appropriate type.
                value = self._try_parse_arg(option.type, stream.next())
                self._set_opt(char, value)

                # If the option is a greedy list, keep trying to parse values
                # until we hit the next option or the end of the stream.
                if option.greedy:
                    while stream.has_next_value():
                        value = self._try_parse_arg(option.type, stream.next())
                        self._set_opt(char, value)

            # We're missing a required option value.
            else:
                err("missing argument for the -%s option" % char)
