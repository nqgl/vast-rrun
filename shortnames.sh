#!/bin/bash


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) # this line is from https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script

rrun(){
    python3 $RRUN_DIRECTORY/run.py $@
}


sid(){
    RRUN_ID=$1
}

rsetup(){
    rrun --id $RRUN_ID --setup --export python3 train_hsae_sae0.py
}

rpy(){
    rrun --id $RRUN_ID --export python3 $@
}

copymodels(){
    rrun --id $RRUN_ID --copymodel '*' $@
}

this(){
    rrun --id $RRUN_ID --export $@
}


clippipe(){
	s=
	while read line; do
		s=${s}${line}
	done
	echo $s
	echo $s | xclip -selection clipboard -i
}

cptmr(){
    echo 'export PYTHONPATH=~/:$PYTHONPATH; pip install transformer_lens; cd modified-SAE; python3 train_hsae_sae0.py' | clippipe
}
tm(){
    $(rrun $RRUN_ID --tmux) 
}