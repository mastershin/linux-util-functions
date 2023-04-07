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

# If running from remote terminal, there's no beep sound, then run this from local terminal (via ssh, every 10 seconds)
# DANGER=100; SERVER=xxxx.yyyy.zzz; while true; do (ssh $SERVER 'M=$(free -g | awk "NR==2 {print \$3}"); [[ $M -gt '$DANGER' ]] && echo $(date +%T) $HOST mem-used=$M' | (read -r && echo -e "$REPLY\a" && cat)); sleep 10; done
