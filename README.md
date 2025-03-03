1. https://github.com/wbthomason/packer.nvim
2. `cp init.rua ~/.config/nvim/`
3. `:PackerInstall`
4. `gem install solargraph`
5. `brew install ripgrep`
6. `:PackerSync`
7. `:Copilot setup` ref. https://github.com/github/copilot.vim

### Troubleshooting

`:Copilot setup`

```
Error detected while processing function copilot#Command[33]..function copilot#Command[25]..3:
line   50:
E121: Undefined variable: status
E116: Invalid arguments for function get
```

remove `~/.config/github-copilot`

ref. https://github.com/orgs/community/discussions/152171#discussioncomment-12324088
