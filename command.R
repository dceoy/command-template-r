#!/usr/bin/env Rscript

'Tiny R script as an executable command

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
  -h, --help      Print help and exit' -> doc


script_version <- 'v0.0.1'


fetch_script_root <- function() {
  ca <- commandArgs(trailingOnly = FALSE)
  fa <- ca[grepl('^--file=', ca)]
  if (length(fa) == 1) {
    f <- sub('--file=', '', fa)
    l <- Sys.readlink(f)
    if (is.na(l)) {
      script_path <- normalizePath(f)
    } else if (startsWith(l, '/')) {
      script_path <- normalizePath(l)
    } else {
      script_path <- normalizePath(file.path(dirname(f), l))
    }
    return(dirname(script_path))
  } else {
    return(normalizePath(getwd()))
  }
}


main <- function(opts, pkgs = NULL, rscripts = NULL,
                 root_dir = fetch_script_root()) {
  if (opts[['--debug']]) {
    options(warn = 1)
    print(opts)
  }

  if (! is.null(opts[['--seed']])) {
    message('>>> Set a random seed')
    set.seed(opts[['--seed']])
    message(opts[['--seed']])
  }

  if (! is.null(pkgs)) {
    message('>>> Load packages')
    sapply(pkgs, library, character.only = TRUE)
  }

  if (! is.null(rscripts)) {
    message('>>> Load scripts')
    lapply(file.path(root_dir, rscripts), source)
  }

  n_cpu <- ifelse(is.null(opts[['--cpus']]),
                  parallel::detectCores(), as.integer(opts[['--cpus']]))
  in_dir <- normalizePath(opts[['--in']])
  out_dir <- normalizePath(opts[['--out']])

  message('>>> Show configurations')
  message('Script directory path:       ', root_dir)
  message('Input directory path:        ', in_dir)
  message('Output directory path:       ', out_dir)
  message('CPU cores:                   ', n_cpu)

  #
  # message('>>> Start the anaysis workflow')
  # start_analysis()
  #
}


if (! interactive()) {
  library('docopt', quietly = TRUE)
  main(opts = docopt::docopt(doc, version = script_version))
}
