# Providers

This folder relies on asdf to abstract and systemetize the provider setup and config.

The point is to keep the init.vim portable and do all the necessary language and module installs
and setups, using local or otherwise fenced installs where possible so as not to rely on the global
state.

### Known Issues

 - nvim executes `node neovim-node-host` rather than just `neovim-node-host`. Annoying. The `nodejs
     setup` will symlink the correct binary rather than wrap it like the others do.
