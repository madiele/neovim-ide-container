1) copiare tutto in %appdata%\..\Local\nvim\
2) andare in nvim-data\lazy\telescope-fzf-native.nvim\ e lanciare
    mkdir build
    gcc -O3 -Wall -Werror -fpic -shared src/fzf.c -o build/libfzf.dll
3) se serve editare lsp.lua con path di omnisharp
