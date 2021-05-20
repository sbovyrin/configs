# My daily tools configurations

> Required: `fzf`
> Optional: `ripgrep`

## `.bashrc`

```sh
curl -Ss# -o "${HOME}/.bashrc" \
  https://raw.githubusercontent.com/sbovyrin/configs/master/.bashrc
```

## Shell aliases

```sh
curl -Ss# -o "${HOME}/.aliases" \
  https://raw.githubusercontent.com/sbovyrin/configs/master/.aliases
```

## Git config

```sh
curl -Ss# -o "${HOME}/.gitconfig" \
  https://raw.githubusercontent.com/sbovyrin/configs/master/.gitconfig
```

## Vim config

```sh
mkdir -p "${HOME}/.config/nvim/colors" \
&& curl -Ss# -o "${HOME}/.config/nvim/init.vim" \
  https://raw.githubusercontent.com/sbovyrin/configs/master/nvim/init.vim \
&& curl -Ss# -o "${HOME}/.config/nvim/colors/sb.vim" \
  https://raw.githubusercontent.com/sbovyrin/configs/master/nvim/colors/sb.vim
```
