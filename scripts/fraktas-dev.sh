SESH="Fraktas_Dev_Session"

tmux start-server

tmux has-session -t $SESH 2>/dev/null

tmux attach-session -t $SESH

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "claude"

  tmux send-keys -t $SESH:claude "cd ~/git/fraktas-app/" C-m
  tmux send-keys -t $SESH:claude "claude" C-m

  tmux new-window -t $SESH -n "dotnet"
  tmux send-keys -t $SESH:dotnet "cd ~/git/fraktas.api/Fraktas.Api/" C-m
  tmux send-keys -t $SESH:dotnet "dotnet run" C-m

  tmux new-window -t $SESH -n "docker"
  tmux send-keys -t $SESH:docker "cd ~/git/fraktas.api/" C-m
  tmux send-keys -t $SESH:docker "docker compose up" C-m

  tmux select-window -t $SESH:claude
fi

tmux attach-session -t $SESH
