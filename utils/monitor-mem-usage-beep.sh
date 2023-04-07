#!/usr/bin/env bash
# Beeps when the used memory in GB exceeds this value (run in remote terminal)

DANGER=100
while true; do
  M=$(free -g | awk "NR==2 {print \$3}")
  ([[ $M -gt $DANGER ]] && echo $(date +%T) $HOST mem-used=$M) | (read -r && echo -e "$REPLY\a" && cat)
  sleep 1
done

# One-liner
# while true; do M=$(free -g | awk "NR==2 {print \$3}"); ([[ $M -gt $DANGER ]] && echo $(date +%T) $HOST mem-used=$M) | (read -r && echo -e "$REPLY\a" && cat); sleep 1; done
