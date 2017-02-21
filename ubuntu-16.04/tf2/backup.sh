#!/bin/bash
new=$1

find ./tf2 -name *.mf|sed "s/\(.*\)\.mf/cp \1  \1.$new/"|sh
find ./tf2 -name  *mf|sed "s/\(.*\)\.mf/cp \1.mf  \1/"|sh

