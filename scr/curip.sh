ip addr show wlp3s0 | grep 'inet ' | awk '{print wlp3s0 $2}'
