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

TILDE_FILES_DIR = 'tilde'
SOURCE_DIR = '~/.dotfiles/{}'.format(TILDE_FILES_DIR)
SOURCE_DIR_RELATIVE = SOURCE_DIR.replace('~/', './')
IGNORE = ['.DS_Store']


def is_dir(path_to_check: str) -> bool:
    return path.isdir(path_to_check)


def is_link(path_to_check: str) -> bool:
    return path.islink(path_to_check)


def read_link(path_to_read: str) -> str:
    return readlink(path_to_read)


def path_exists(path_to_check: str) -> bool:
    return path.lexists(path_to_check)


def strip_trailing_slash(path_to_strip: str) -> str:
    return path_to_strip.rstrip('/')


def force_remove(path_to_remove: str) -> None:
    if not path_exists(path_to_remove):
        return None

    if is_dir(path_to_remove) and not is_link(path_to_remove):
        rmtree(path_to_remove, False)
        return None

    unlink(path_to_remove)


is_equal_with = curry(lambda fn, a, b: fn(a) == fn(b))
is_link_to_path = is_equal_with(strip_trailing_slash)


def is_link_to(dest_path: str, source_path: str) -> bool:
    return is_link(dest_path) and is_link_to_path(read_link(dest_path), source_path)


def get_source_files():
    return [file for file in glob('.*') if file not in IGNORE]


def to_source_file_path(filename: str) -> str:
    return path.join(SOURCE_DIR_RELATIVE, filename)


def to_dest_file_path(filename: str) -> str:
    return path.join(path.expanduser('~'), filename)


def to_source_file_path_printable(source_path: str) -> str:
    return source_path.replace(SOURCE_DIR_RELATIVE, './{}'.format(TILDE_FILES_DIR))


def to_dest_file_path_printable(dest_path: str) -> str:
    return dest_path.replace(path.expanduser('~'), '~')


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


message_formats = {
    'link_exists': '%s => %s (link already exists, skipping)',
    'user_skipped': '%s => %s (different file exists, not overwriting)',
    'link_created': '%s => %s (created new link)',
}


def print_info_message(source_path: str, dest_path: str, message_type: str) -> None:
    template = message_formats.get(message_type)
    source_path_printable = to_source_file_path_printable(source_path)
    dest_path_printable = to_dest_file_path_printable(dest_path)
    print(template % (source_path_printable, dest_path_printable))


def main():
    chdir(path.expanduser(SOURCE_DIR))

    for source_path, dest_path in get_source_dest_path_pairs():
        if get_should_skip_file(dest_path, source_path):
            print_info_message(source_path, dest_path, 'link_exists')
            continue

        if not get_should_overwrite_file(dest_path):
            print_info_message(source_path, dest_path, 'user_skipped')
            continue

        force_remove(dest_path)
        create_link_to(dest_path, source_path)
        print_info_message(source_path, dest_path, 'link_created')


if __name__ == '__main__':
    main()
