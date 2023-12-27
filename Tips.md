## fish change shell
chsh -s /usr/bin/fish
## write to readonly nvim
:w !sudo tee %
## shred remove
shred -vzfu
## fish path
```bash
fish_add_path
echo $fish_user_paths | tr " " "\n" | nl
set --erase --universal fish_user_paths[1]
```

 ## add symbolic link
ln -s 
