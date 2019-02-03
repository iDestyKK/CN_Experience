#!/bin/bash

ip route get 1 | head -1 | awk '{print $7}'
