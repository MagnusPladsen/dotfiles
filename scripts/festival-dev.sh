SESH="Abaris_Festival_Dev_Session"
DIR="~/git/abaris-festival/"

tmux start-server

tmux has-session -t $SESH 2>/dev/null

tmux attach-session -t $SESH

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "nvim"

  tmux send-keys -t $SESH:nvim "cd $DIR/festival-app/" C-m
  tmux send-keys -t $SESH:nvim "nvim" C-m

  tmux new-window -t $SESH -n "webapp"
  tmux send-keys -t $SESH:webapp "cd $DIR/festival-app/" C-m
  tmux send-keys -t $SESH:webapp "yarn dev" C-m

  tmux new-window -t $SESH -n "dotnet"
  tmux send-keys -t $SESH:dotnet "cd $DIR/festival-api/Booking.API/" C-m
  tmux send-keys -t $SESH:dotnet "dotnet run" C-m

  tmux new-window -t $SESH -n "repo"
  tmux send-keys -t $SESH:repo "cd $DIR" C-m

  tmux new-window -t $SESH -n "claude"
  tmux send-keys -t $SESH:claude "cd $DIR" C-m
  tmux send-keys -t $SESH:claude "claude" C-m

  tmux select-window -t $SESH:nvim
fi

tmux attach-session -t $SESH
