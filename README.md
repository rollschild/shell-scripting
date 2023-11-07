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

## User Inputs

- `$0` - the script's name
  - _with path_
  - to use only the script name, use the `basename` command
    - `$(basename $0)`
- up to `$9` for the ninth parameter
- for more parameters, use `${10}`, `${11}`, etc
- To test parameters, use `-n`
  - `if [ -n "$1" ]`

### Special Parameter Variables

- `$#` - number of command-line parameters
- `if [ $# -eq 1 ]`
- `${!#}` - get the value of the last parameter
  - `?` _CANNOT_ be used in `{}`
  - so it's _NOT_ `${?#}`
- To grab _all_ parameters:
  - `$*` - all parameters as a single word
  - `$@` - all parameters as separate words in the _same_ string

### Shifty

- `shift`
  - moves each parameter variable one position to the left by default
  - `shift <pos>`
- use `--` to separate options and parameters
  - `--` indicates end of the option list
  - note: the parameters have no special relationship with the options
- `getopt`
  - `getopt optstring paramters`
  - `optstring` - list of valid option letters
    - colon `:` after the letter which requires a value
    - `q` - ignore error messages
    - _NOT_ working well with parameter values with spaces or quotation marks
      - use `getopts`
- `set`
  - `set --` - replace commandline parameter variables with the values specified by `set`
    - used with `$@`
- `getopts`
  - works on existing shell parameter variables _sequentially_
  - `getopts optstring variable`
  - prepend `optstring` with `:` to suppress error messages
  - uses 2 env variables:
    - `OPTARG` - parameter value
    - `OPTIND` - value of the current location within the parameter list where `getopts` left off
      - incremented by one every time
  - bundles _any_ undefined option into a single output, `?`

### Getting User Input

- `read`
  - either from stdin or file descriptor
  - put data read into a variable
  - if _no_ variable specified, data stored in the special env variable `REPLY`
  - `REPLY`: contains _all_ data entered in the input
  - `read -p` read with a prompt
  - `read -s` in silent mode
    - no input on display
- `read` from a file
  - a single line of a time

### Timing out

- use `-t` to specify a timer
- if expired, exit status is non-zero

### Presenting Data

#### File Descriptors

- `STDIN` - `0`
  - overwritten/redirected by `<`
- `STDOUT` - `1`
  - redirected by `>` or `>>`
- `STDERR` - `2`
  - `2>` - redirecting `STDERR` _only_
  - `1> <file_for_data> 2> <file_for_err>`
  - `&>` - redirect _both_ `STDERR` and `STDOUT` to the _same_ file
    - error messages have a _higher_ priority than stdout

#### Redirecting output

- precede the file descriptor with `&`
  - `>&2`
- To permanently redirect (for the duration of current script) - `exec`
  - `exec 1>testout`
- `exec` starts a _new_ shell

#### Redirecting input

- `exec 0< testinput`

#### Creating custom redirection

- file descriptors `3` through `8`
- redirecting and resetting `STDIN`:

```sh
exec 6<&0
#...
exec 0<&6
```

#### Creating read/write file descriptor

- open a single file descriptor for _both_ input _and_ output
- `exect 3<> testfile`
- _NOTE_!
  - when reading from and writing to the same file, the shell maintains an internal pointer!

#### Closing file descriptors

- to close, redirect to `&-`
  - `exec 3>&-`

#### Listing Open File Descriptors

- `lsof` - list _all_ open file descriptors on the entire Linux system
  - `lsof -p` - by `PID`
- `$$` - current `PID`

#### Suppressing Command Output

- redirect to the `null` file
- `/dev/null`
  - can also be used for input redirection as an input file
    - to quickly remove data from an existing file without having to remove the file and re-create it
    - `cat /dev/null > file_to_be_cleared`

#### Temporary Files

- `/tmp` for temp files
- auto cleaned up at bootup
- `mktemp` - create a unique temp file
  - `mktemp testfile.XXXXXX`
  - by default in the current location
- `mktemp -t testfile.XXXXXX`
  - create in `/tmp`
- `mktemp -d dir.XXXXXX`
  - create temp directory

#### Logging Messages

- `tee`
  - sends data from `STDIN`
  - sends data to _both_:
    - `STDOUT`
    - a file
  - by default overwrites the file
  - `-a` to append

### Script Control

- by default `SIGQUIT` and `SIGTERM` are ignored by Bash shell
  - but `SIGHUP` and `SIGINT` are _NOT_ ignored
- when `SIGHUP` received, _before_ the Bash shell exits, it passes the `SIGHUP` signal to any processes started by the shell,
  - including any running shell scripts
- with `SIGINT` signal, shell is just interrupted
  - also passed to any processes started by the shell
- `Ctrl+C` generates a `SIGINT`
- To _pause_ the process,
  - `Ctrl+Z` - generates `SIGTSTP`
- **stop** vs. **terminate** - different!
  - **stop**ing a process leaves the program in memory
    - able to resume where it left off
- to see the list of (stopped) jobs, do `ps -l`
  - state (`S`) of `T`
    - either traced or stopped
- type `exit` twice to exit a shell with stopped jobs
- `kill -9 <pid>` sends `SIGKILL` (`9`) signal to terminate
- **Trapping** signals
  - `trap <commands> <signals>`
  - watch for `<commands>` and intercept them from shell
- To keep critical operations flowing in the script, do:
  - `trap "" SIGINT <other_signals>`
- To trap upon script exit
  - `trap <commands> EXIT`
- To handle `trap` differently in various sections in a script
  - reissue `trap` with new options
- To remove a trap
  - `trap -- <list_of_signals>`
  - `<list_of_signals>` - list of signals you want to return to default behavior
- To see processes running in the background, `ps -e`
- `<command> &` - run a command/script in the background
  - still uses `STDOUT` and `STDERR` for messages
- background processes started from a terminal session will exit if the session exits
- To keep the script running after the terminal session exits,
  - `nohup <command>`
  - blocks any `SITHUP` signals
  - _NOT_ associated with the terminal session anymore
  - no longer has `STDOUT` and `STDERR` output channels
  - automatically redirected to `nohup.out`
- To see all jobs, run `jobs`
- To resume the stopped process,
  - `bg` and `fg`
  - if the default job (with the `+` sign) - no need to specify the job id
  - in Bash, `fg <job_id>`
  - in zsh, `fg %<job_id>`
- **scheduling priority**
  - a.k.a. **nice value**
  - the amount of CPU time the kernel assigns to the process relative to other processes
  - by default all processes started from the shell have the same priority
  - `-20` (highest) <-> `+19` (lowest)
- To set the priority,
  - `nice -n <priority> <command>`
  - by default normal users are _NOT_ allowed to set negative (higher than default) priorities
  - only root users can do that
- To change priority of a running process
  - `renice -n <priority> -p <PID>`
- Schedule a job
  - `at` - specify a _future_ time
  - `at [-f filename] time`
  - submits job to a queue
  - `atd` - the `at` daemon
    - runs in background
    - checks jobs under `/var/spool/at` or `/var/spool/cron/atjobs`
    - checks very 60 seconds
  - use `-M` to suppress any output generated by jobs
- **Job Queue**
  - 52 queues for different priorities
  - `a` to `z`; `A` to `Z`
  - by default, jobs submitted to `a` queue
  - `-q` to specify queue
  - by default `STDOUT`/`STDERR` are redirected to OS mail system
- `atq` - view pending jobs
- `atrm <job_id>` - remove a job
- `cron` - checks `cron` tables
  - to run on the last day of every month:
    ```sh
    cron 00 12 28-31 * * if [ "$(date +%d -d tomorrow)" = 01 ] ; then <command> ; fi
    ```
- `crontab -l` - list an existing `cron` table
  - by default the `cron` table does _NOT_ exist for a user
- `cron` does _NOT_ retroactively run missed jobs
  - to achieve that, use `anacron`
- `anacron`
  - job is guaranteed to run
  - _ONLY_ dealing with programs under `cron` directories
    - `/etc/cron.monthly`
    - `/etc/cron.daily`
    - `/etc/cron.weekly`
    - _BUT NOT_ **hourly**!
  - Uses **timestamps** to determine if the jobs have been run
  - A timestamp file exists for _each_ `cron` directory, located in
    - `/var/spool/anacron`
  - its own table: `/etc/anacrontab`
- To run a script every time a new Bash shell is started
  - put the scripts in:
    - `$HOME/.bash_profile`
    - `$HOME/.bash_login`
    - `$HOME/.profile`

### Functions

```sh
function name {
    commands
}

# or,
name() {
commands
}
```

- To call a function, just specify the function name on a line
- Redefining a function name will override the original function definition
- Bash shell treats functions like mini-scripts
  - with an exit status
- exit status:
  - by default, the exit status returned by the last command in the function
  - `$?` - check the exit status
- Use `return` to exit the function with a specific exit status
  - NOTE:
    - Remember to retrieve the return value _as soon as_ the function completes
    - Remember exit status must be `0` - `255`
  - cannot return a string
- Capture output of a function to a shell variable
  - `result=$(func)`
- Passing parameters to function
  - inside the function, `$0`, `$1`, `$2`, etc
  - `$0` is name of function
  - `$#` is number of parameters passed to the function - excluding the function itself
- Parameters passed to the script are _NOT_ the same as those passed to the function within!
  - Need to manually pass the parameters to the function!
- Scope of variables
  - **global** by default _everywhere_
  - `local`

#### Passing arrays to functions

- passing the array variable as a function parameter - it would _NOT_ work!
  - only the first element of the array will be picked up
  - you _MUST_ disassemble the array variable into individual elements!
    - use those individual as function parameters

#### Returning arrays from functions

- function uses `echo` to output _individual_ array values in the proper order
  - the script reassembles back into a new array

#### Creating a library

- `source` - the key
  - executes commands within the current shell context instead of creating a new shell
  - used to run the library file script inside your shell script
  - the **dot operator** - shortcut alias of `source`
    - `. ./<script>`

#### Using functions on CLI

- `$ function <func_name> { <command>; }`
