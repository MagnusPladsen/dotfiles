brew install --cask nikitabobko/tap/aerospace

# aerospace-layout-manager https://github.com/CarterMcAlister/aerospace-layout-manager
curl -sSL https://raw.githubusercontent.com/CarterMcAlister/aerospace-layout-manager/main/install.sh | bash

mkdir -p $HOME/.config/aerospace
if [ -f "$HOME/.config/aerospace/aerospace.toml" ]; then
  cp $HOME/.config/aerospace/aerospace.toml $HOME/.config/aerospace_backup
fi
ln -sf "$PWD/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"

if [ -f "$HOME/.config/aerospace/layouts.json" ]; then
  cp $HOME/.config/aerospace/layouts.json $HOME/.config/aerospace_backup
fi
ln -sf "$PWD/aerospace/layouts.sjon" "$HOME/.config/aerospace/layouts.json"
