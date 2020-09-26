#!/usr/bin/env python

"""
Dotfiles syncronization.
Makes symlinks for files that need to go in $HOME.
e.g. `~/dotfiles/tilde/.zshrc` -> `~/.zshrc`.
"""

from os import path, chdir, readlink, symlink, unlink
from glob import glob
from shutil import rmtree
from typing import Callable

from toolz.curried import curry, pipe, identity

SOURCE_DIR = '~/dotfiles/tilde'
IGNORE = ['.DS_Store']


def is_link(link_path: str) -> bool:
    return path.islink(link_path)


def read_link(link_path: str) -> str:
    return readlink(link_path)


def strip_trailing_slash(path_str: str) -> str:
    return path_str.rstrip('/')


def force_remove(dir_path):
    if path.isdir(dir_path) and not path.islink(dir_path):
        rmtree(dir_path, False)
    else:
        unlink(dir_path)


is_equal_with = curry(lambda fnA, fnB, a, b: fnA(a) == fnB(b))

is_link_to_path = is_equal_with(
    pipe(read_link, strip_trailing_slash),
    strip_trailing_slash
)


def is_link_to(link_path: str, target_path: str) -> bool:
    return is_link(link_path) and is_link_to_path(link_path, target_path)


def main():
    chdir(path.expanduser(SOURCE_DIR))
    for filename in [file for file in glob('.*') if file not in IGNORE]:
        dotfile = path.join(path.expanduser('~'), filename)
        source = path.join(SOURCE_DIR, filename).replace('~', '.')

        # Check that we aren't overwriting anything
        if path.lexists(dotfile):
            if is_link_to(dotfile, source):
                continue

            response = input("Overwrite file `%s'? [y/N] " % dotfile)
            if not response.lower().startswith('y'):
                print("Skipping `%s'..." % dotfile)
                continue

            force_remove(dotfile)

        symlink(source, dotfile)
        print("%s => %s" % (dotfile, source))


if __name__ == '__main__':
    main()
