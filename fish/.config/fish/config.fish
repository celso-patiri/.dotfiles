if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""
alias vim nvim

oh-my-posh init fish --config ~/.posh-config.json| source
