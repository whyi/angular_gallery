#!/bin/bash
cd app
coffee -o js/ -cw coffee/ &
cd ../test
coffee -o unit -cw coffee/unit/ &

