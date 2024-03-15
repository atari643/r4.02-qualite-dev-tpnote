#!/usr/bin/env sh
###
#
#  @file test_gitignore.sh
#  @copyright 2023-2024 Univ. Bordeaux. All rights reserved.
#
#  @version 1.2.3
#  @author SKUTECKI Paul
#  @date 2024-03-09
#
# This script check that .gitignore exist
#
###

if [ -f ../.gitignore ]; then
    echo 'File exists.'
    exit 0
else
    echo 'File does not exist.'
    exit 1
fi
