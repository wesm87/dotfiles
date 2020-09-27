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

from toolz.curried import curry, pipe, identity, map

SOURCE_DIR = '~/.dotfiles/tilde'
IGNORE = ['.DS_Store']


def is_dir(_path: str) -> bool:
    return path.isdir(_path)


def is_link(_path: str) -> bool:
    return path.islink(_path)


def read_link(_path: str) -> str:
    return readlink(_path)


def link_exists(_path: str) -> bool:
    return path.lexists(_path)


def strip_trailing_slash(_path: str) -> str:
    return _path.rstrip('/')


def force_remove(_path: str) -> None:
    if is_dir(_path) and not is_link(_path):
        rmtree(_path, False)
    else:
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


get_source_dest_path_pairs = pipe(
    get_source_files,
    map(lambda filename: [
        to_source_file_path(filename),
        to_dest_file_path(filename),
    ])
)


def get_should_overwrite_file_from_user_input(dest_path: str) -> bool:
    response = input("Overwrite file `%s'? [y/N] " % dest_path)
    should_overwrite_file = response.lower().startswith('y')

    if not should_overwrite_file:
        print("Skipping `%s'..." % dest_path)

    return should_overwrite_file


def get_should_overwrite_file(dest_path: str, source_path: str) -> bool:
    if not link_exists(dest_path):
        return False

    if is_link_to(dest_path, source_path):
        return False

    return get_should_overwrite_file_from_user_input(dest_path)


def force_remove_if_needed(dest_path: str, source_path: str) -> None:
    if get_should_overwrite_file(dest_path, source_path):
        force_remove(dest_path)


def create_link_to(dest_path: str, source_path: str) -> None:
    symlink(source_path, dest_path)
    print("%s => %s" % (source_path, dest_path))


def main():
    chdir(path.expanduser(SOURCE_DIR))

    for source_path, dest_path in get_source_dest_path_pairs():
        force_remove_if_needed(dest_path, source_path)
        create_link_to(dest_path, source_path)


if __name__ == '__main__':
    main()
