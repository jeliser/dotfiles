set -eu

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash


echo "" >> ~/.bashrc.local
echo "if [ -f ~/.git-completion.bash ]; then" >> ~/.bashrc.local
echo "  . ~/.git-completion.bash" >> ~/.bashrc.local
echo "fi" >> ~/.bashrc.local
echo "" >> ~/.bashrc.local

