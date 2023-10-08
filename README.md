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
    ```console
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
    ```console
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
