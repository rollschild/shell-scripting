# Basic POSIX Shell Scripting

## Shell Scripting Basics

- In NixOS, the best way to run `#!/bin/bash` is to use `#!/usr/bin/env bash` as **shebang**
- `$ set` - to display a complete list of active environment variables available
- User variables
  - up to _20_ letters/digits/underscores
  - _case sensitive_
  - assignments should _NOT_ have spaces at all
    - `var=-10`
  - stored as **text strings** by the shell script
- Command substitution
  - Two ways:
    - the backtick character
    - The `$()` format
  - a **subshell** is created to run the enclosed command
    - a _separate_ child shell
    - any variables create in the parent shell will _NOT_ be available to commands in the subshell
- **Subshells** are also created if command is run from the CLI using the `./` path
- Output redirection
  - `command > outputfile`
    - `>` creates the outputfile
    - _overwrites_ existing file
    - use `>>` to _append_ (instead of overwrite)
- Input redirection
  - `command < inputfile`
  - e.g. `wc < test1.sh`
    - number of lines, words, and bytes
  - **inline input redirection**
    - `<<`
    - needs a text marker
    ```sh
    wc << <marker>
    - <text>
    - <marker>
    ```
    - uses the prompt defined in `$PS2`
- Pipes
  - `command1 | command2`
  - _both_ commands are run _at the same time_
  - _no_ intermediate files/buffers are used to transfer the data
  - piping operates _in real time_
- Paging commands:
  - `less`
  - `more`
- Math
  - Two ways to do math:
  - `expr` command
    - `$ expr 1 + 5`
    - old and _NOT_ recommended anymore
  - square brackets `$[operation]`
    - looks like also deprecated
    - integer arithmetic _ONLY_
    - `zsh` supports floating-point operations
  - use `$((...))`
- `bc` - the Bash calculator
  - supports floating-point solutions
  - use `scale` to specify precision (decimal points)
    - default is `0`
  - `variable=$(echo "options; expression" | bc)`
  - able to do inline input redirection
    ```sh
    variable=$(bc << EOF
    options
    statements
    expressions
    EOF
    )
    ```
- Exiting the script
  - every command has an **exit status**
  - **exit status**: 0 - 255
  - `$?`: special variable to grab exit status of the last executed command
    - needs to be run _immediately_ after
  - by default, the script exits with the exit status of the last command in the script
    - overwrite that by manually `exit <exit_code>`
    - if `<exit_code>` is larger than `255`, use modulo `<exit_code> % 256`

## Structured Commands

- `if-then`
  ```sh
  if command # checking if exit status of `command` is zero
  then
      commands
  fi
  ```
  - alternatively, `if command; then`
- `if-then-else`
  ```sh
  if command
  then
      commands
  else
      commands
  fi
  ```
- `if-then` can _ONLY_ evaluate the condition of a command's exit code
- to evaluate other conditions, use `test`
  - `test` - test whether a variable has content
  ```sh
  if test condition
  then
      commands
  fi
  ```
- `if [ condition ]` - an alternative way to test a condition without `test`
  - there _must_ be a space after the `[` and before the `]`
- Numeric comparisons
  - bash can _only_ handle integer comparisons
- String comparisons
  - use _escaped_ `\>` and `\<`
  - otherwise they are interpreted as _redirections_
  - when comparing orders, `\<` and `\>` have _different_ directions than `sort`
  - `sort` puts lowercases first
- `if [ -n $string ]` - test whether `$string` is non-zero in length
- `if [ -z $string ]` - test whether `$string` is zero in length
- `-nt`/`-ot`
  - files newer/older than the other?
  - should check whether file exists first
- Compound testing
  - `if [ condition1 ] && [ condition2 ]`
  - `if [ condition1 ] || [ condition2 ]`
- Advanced `if-then`
  - Run a command in **subshell** using `(command)`
  - Math expressions in `((expression))`
  - Advanced string handling in `[[...]]`
    - allows for **pattern matching**
- `case`

  ```sh
  case variable in
  pattern1 | pattern2) commands1;;
  pattern3) commands2;;
  *) default commands;;
  esac
  ```

- `for`

  ```sh
  for var in list # separated by space
  do
    commands
  done
  ```

- `IFS` - **Internal Field Separator**
  - special environment variable
  - defines a _list_ of chars used by bash as field separators
  - Default field separators:
    - a space
    - a tab
    - a newline
  - REMEMBER to reset it afterwards!
    ```sh
    IFS.OLD=$IFS
    IFS=$'\n'
    ...
    IFS=$IFS.OLD
    ```
  - specify more than one character: `IFS="$'\n':;"`
- **File globbing**
  - the process of producing filenames/pathnames that match a specified wildcard
- C-style `for` loop
  - `for (( variable assignment ; condition ; iteration process ))`
- `while`

  ```sh
  while test command
  do
      other commands
  done
  ```

  - terminates when the exit status of `test command` changes
  - multiple test commands _are_ allowed - `while` terminates only when the exit status of the last test command changes

- `until`
  - opposite of `while`
  - terminates when exit status of test command goes from non-zero to zero
- `break`
  - `break n` - the level of loop to break out of
  - by default `n` is `1`
- `continue`
  - ` continue n`
- Processing the output of a loop
  - `done > output.txt`
  - `done < input.txt`
  - `done | sort`
-
