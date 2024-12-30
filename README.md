# My neovim config

This config works for me on Mac, Windows, and Linux. No Guarantees it will work for anyone else. 


### Requirements

- Neovim nightly installed
- Nodejs installed
- Ripgrep installed
- Git installed
- A compiler for C available in PATH
- A current Elixir and OTP (erlang) version installed
- Lazygit installed (optional)
- Golang installed(optional)

### To install: 
- Add to the appropriate location for Neovim config on your OS
- Open Neovim. Lazy will install itself and prompt for Neovim restart
- Restart Neovim, watch the messages as it loads everything else

### Things to note: 
- There are artifacts from old experiments and previous config decisions that I haven't removed yet. Getting it 100% clean is a non-goal of mine. I want it working and then I want to write code for projects. I have done some cleaning up for my own sanity though. Hopefully anyone that takes the time to read through things doesn't get confused. 
- The tailwind LSP server doesn't start and attach automatically. That server is slow and it makes completion slow and it makes me mad. I have a keybind `<leader>tt` to toggle it on and off, and 90% of the time I have it off.
- I don't use a file tree, nor do I use the tree view of Netrw. Oil.nvim works just fine for my needs, combined with Telescope and Harpoon.
- My typescript errors in the buffer are formatted different from what TSServer spits out. For some reason MS thought it was wise to add a million lines of context on a gnarly error buried in generics and then put the actual problem at the bottom. I have an error formatter that puts what it needs to stop being an error at the top, and then the context at the bottom. Should be default in the world, now it's default for me at least. 

### Contributing

Right now this is my personal config. Not accepting external contributions. 

However you are free to use any part of this repo for your own purposes. 
