#!/bin/bash

set -u -e

latexmk -g presentation
cp ./build/presentation.pdf .
