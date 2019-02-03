#!/bin/bash

free -m | head -n 2 | tail -n 1 | awk '{ printf("%d MB / %d MB", $3, $2); }'
