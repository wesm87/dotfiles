#!/usr/bin/env python3

"""
Dotfiles syncronization.
Makes symlinks for files that need to go in $HOME.
e.g. `~/dotfiles/tilde/.zshrc` -> `~/.zshrc`.
"""

from os import path, chdir, readlink, symlink, unlink
from glob import glob
from shutil import rmtree
from typing import Callable

from toolz.curried import curry, compose, identity, map

SOURCE_DIR = '~/.dotfiles/tilde'
IGNORE = ['.DS_Store']


def is_dir(_path: str) -> bool:
    return path.isdir(_path)


def is_link(_path: str) -> bool:
    return path.islink(_path)


def read_link(_path: str) -> str:
    return readlink(_path)


def path_exists(_path: str) -> bool:
    return path.lexists(_path)


def strip_trailing_slash(_path: str) -> str:
    return _path.rstrip('/')


def force_remove(_path: str) -> None:
    if not path_exists(_path):
        return None

    if is_dir(_path) and not is_link(_path):
        rmtree(_path, False)
        return None

    unlink(_path)


is_equal_with = curry(lambda fn, a, b: fn(a) == fn(b))


is_link_to_path = is_equal_with(strip_trailing_slash)


def is_link_to(dest_path: str, source_path: str) -> bool:
    return is_link(dest_path) and is_link_to_path(read_link(dest_path), source_path)


def get_source_files():
    return [file for file in glob('.*') if file not in IGNORE]


def to_source_file_path(filename: str) -> str:
    return path.join(SOURCE_DIR, filename).replace('~', '.')


def to_dest_file_path(filename: str) -> str:
    return path.join(path.expanduser('~'), filename)


get_source_dest_path_pairs = compose(
    map(lambda filename: [
        to_source_file_path(filename),
        to_dest_file_path(filename),
    ]),
    get_source_files,
)


def get_should_skip_file(dest_path: str, source_path: str) -> bool:
    return path_exists(dest_path) and is_link_to(dest_path, source_path)


def get_should_overwrite_file(dest_path: str) -> bool:
    if not path_exists(dest_path):
        return True

    response = input("Overwrite file `%s'? [y/N] " % dest_path)
    should_overwrite_file = response.lower().startswith('y')

    if not should_overwrite_file:
        print("Skipping `%s'..." % dest_path)

    return should_overwrite_file


def create_link_to(dest_path: str, source_path: str) -> None:
    symlink(source_path, dest_path)
    print("%s => %s" % (source_path, dest_path))


def main():
    chdir(path.expanduser(SOURCE_DIR))

    for source_path, dest_path in get_source_dest_path_pairs():
        if get_should_skip_file(dest_path, source_path):
            continue

        if not get_should_overwrite_file(dest_path):
            continue

        force_remove(dest_path)
        create_link_to(dest_path, source_path)


if __name__ == '__main__':
    main()
