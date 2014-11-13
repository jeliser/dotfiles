
SESSIONNAME="Base_View"
tmux has-session -t $SESSIONNAME >> /dev/null

if [ $? -ne 0 ]
  then
    # new session with name $SESSIONNAME and window 0 named "base"
    tmux new-session -s $SESSIONNAME -d
    tmux attach -t $SESSIONNAME
fi


