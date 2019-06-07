command-template-r
==================

Tiny R script as an executable command on Linux and macOS

- R script scaffold for command-line tool development
  - Default options
    - `--debug`: Run with debug logging
    - `--seed`: Set a random seed
    - `--cpus`: Limit CPU cores for multithreading
    - `--in`: Set an input directory
    - `--out`: Set an output directory
    - `--version`: Print version and exit
    - `-h, --help`: Print help and exit
- Dependencies:
  - R
  - docopt.R

Usage
-----

1.  Install [docopt.R](https://github.com/docopt/docopt.R).

    ```sh
    $ R -e 'install.packages(pkgs = "docopt", dependencies = TRUE, repos = "https://cran.rstudio.com/");'
    ```

2.  Download `command.R`.

    ```sh
    $ curl -SLO https://raw.githubusercontent.com/dceoy/command-template-r/master/command.R
    $ chmod +x command.R
    ```

3.  Test `command.R`.

    ```sh
    $ ./command.R --help
    ```

    Expected output:

    ```
    Tiny R script as an executable command

    Usage:
      command.R [--debug] [--seed=<int>] [--cpus=<int>] [--in=<dir>] [--out=<dir>]
      command.R --version
      command.R -h|--help

    Options:
      --debug         Run with debug logging
      --seed=<int>    Set a random seed
      --cpus=<int>    Limit CPU cores for multithreading
      --in=<dir>      Set an input directory [default: .]
      --out=<dir>     Set an output directory [default: .]
      --version       Print version and exit
      -h, --help      Print help and exit
    ```

4.  Rename and edit the script.

    ```sh
    $ mv command.R your_command.R
    $ vim your_command.R            # => edit
    ```
