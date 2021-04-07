#!/usr/bin/env python3

"""
Dotfiles syncronization.
Makes symlinks for files that need to go in $HOME.
e.g. `~/dotfiles/tilde/.zshrc` -> `~/.zshrc`.
"""

from os import path, chdir, readlink, symlink, unlink
from glob import glob
from shutil import rmtree

from toolz.curried import curry, compose, map

TILDE_FILES_DIR = 'tilde'
SOURCE_DIR = '~/.dotfiles/{}'.format(TILDE_FILES_DIR)
SOURCE_DIR_RELATIVE = SOURCE_DIR.replace('~/', './')
IGNORE = ['.DS_Store']

MESSAGE_TEMPLATES = {
    'link_exists': '%s => %s (link already exists, skipping)',
    'user_skipped': '%s => %s (different file exists, not overwriting)',
    'link_created': '%s => %s (created new link)',
    'should_overwrite_file': 'Overwrite file `%s`? [y/N] ',
}


def get_formatted_message(message_type, template_args):
    template = MESSAGE_TEMPLATES.get(message_type)
    return template % template_args


def print_formatted_message(message_type, template_args):
    print(get_formatted_message(message_type, template_args))


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


def to_source_file_path(file_name: str) -> str:
    return path.join(SOURCE_DIR_RELATIVE, file_name)


def to_dest_file_path(file_name: str) -> str:
    return path.join(path.expanduser('~'), file_name)


def to_source_file_path_printable(source_path: str) -> str:
    return source_path.replace(SOURCE_DIR_RELATIVE, './{}'.format(TILDE_FILES_DIR))


def to_dest_file_path_printable(dest_path: str) -> str:
    return dest_path.replace(path.expanduser('~'), '~')


get_source_dest_path_pairs = compose(
    map(lambda file_name: [
        to_source_file_path(file_name),
        to_dest_file_path(file_name),
    ]),
    get_source_files,
)


def get_should_skip_file(dest_path: str, source_path: str) -> bool:
    return path_exists(dest_path) and is_link_to(dest_path, source_path)


def get_should_overwrite_file(dest_path: str) -> bool:
    if not path_exists(dest_path):
        return True

    dest_path_printable = to_dest_file_path_printable(dest_path)
    user_question = get_formatted_message(
        'should_overwrite_file',
        dest_path_printable
    )
    response = input(user_question)
    should_overwrite_file = response.lower().startswith('y')

    return should_overwrite_file


def create_link_to(dest_path: str, source_path: str) -> None:
    symlink(source_path, dest_path)


def main():
    chdir(path.expanduser(SOURCE_DIR))

    for source_path, dest_path in get_source_dest_path_pairs():
        source_path_printable = to_source_file_path_printable(source_path)
        dest_path_printable = to_dest_file_path_printable(dest_path)
        message_template_args = (source_path_printable, dest_path_printable)

        if get_should_skip_file(dest_path, source_path):
            print_formatted_message('link_exists', message_template_args)
            continue

        if not get_should_overwrite_file(dest_path):
            print_formatted_message('user_skipped', message_template_args)
            continue

        force_remove(dest_path)
        create_link_to(dest_path, source_path)
        print_formatted_message('link_created', message_template_args)


if __name__ == '__main__':
    main()
