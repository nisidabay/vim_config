#!/usr/bin/env bash

################################################################################
# This is a one-shot script to set up a new vim_config repo
# Previously and empty repo was cloned from the vim_config repo
# Clone the vim_config.git repo and create the vim_config directory
# Manually copy the old-school plugins from the existing .vim installation:
# touch local_plugins/Colorizer.vim
# touch local_plugins/unicode.vim
# touch local_plugins/yuyuko.vim
# touch local_plugins/snippets.vim

################################################################################
# Clone your new repo
gh repo clone nisidabay/vim_confi
cd vim_config || exit

# Create directories
mkdir local_plugins

# Create all the files (with placeholder content to start)
touch vim_config_structure.sh settings.vim mappings.vim plugins.vim coc-config.vim
touch local_plugins/Colorizer.vim
touch local_plugins/unicode.vim
touch local_plugins/yuyuko.vim
touch local_plugins/snippets.vim

# Create a basic .gitignore
cat > .gitignore << 'EOL'
# Vim files
*.swp
*.swo
*~

# Plugin directories that will be installed
autoload/*
bundle/*
colors/*
doc/*
ftdetect/*
lsp/*
pack/*
plugged/*
plugin/*
sessions/*
spell/*
syntax/*
undodir/*
view/*


# Except the local_plugins directory
!local_plugins/
EOL

# Add files to git
git add .
git commit -m "Initial structure setup"
git push origin main
