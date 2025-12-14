setopt auto_cd 　　　        #一致するディレクトリに cdなしで移動できる
setopt correct              #コマンドのスペルを修正(正しい可能性のある候補を表示)
setopt correct_all          #コマンドラインの引数のスペルを修正
setopt hist_ignore_dups     #直前と同じコマンドは履歴に追加しない
setopt share_history　　    #他のzshで履歴を共有する
setopt inc_append_history　 #即座に履歴を保存する

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
