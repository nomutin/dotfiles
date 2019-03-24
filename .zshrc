autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000

 
alias brup='brew update && brew upgrade'


function gcom() {
    echo "type commit massage >> "; read ms;
    git add -A && git status && git commit -m "$ms" && git push;
}

function gcre() {
    yourid   = "nomutin" 
    yourpass = "nomura0508" 
    git init && git add -A && git status;
    echo "type repo name >> "; read name;
    echo "type repo description >> "; read description;
    # github
    curl -u ${yourid} https://api.github.com/user/repos -d '{"name":"'"${name}"'","description":"'"${description}"'","private":true}';
    git commit -m "first commit";
    git remote add origin https://github.com/${yourid}/${name}.git;
    git remote set-url origin git@github.com:${yourid}/${name}.git;
    git push --set-upstream origin master;
}
