FROM rust:1.68

ENV DEBIAN_FRONTEND=noninteractive

USER root
ENV USER=root

# Install essentials
RUN apt-get update \
    && apt-get install -y build-essential curl git exuberant-ctags software-properties-common gnupg locales unzip wget python3-pip virtualenv \
    && apt-get clean

# Install neovim
RUN apt-get update --allow-unauthenticated \
    && add-apt-repository -y ppa:neovim-ppa/unstable \
    && apt-get install -y neovim \
    && mkdir -p ~/.config/nvim/ \
    && apt-get clean

# Install node (neded for some lsp)
RUN apt-get update \
    && curl -sL https://deb.nodesource.com/setup_14.x  | bash - \
    && apt-get install -y nodejs\
    && apt-get clean

ENV PATH="/root/.local/bin:${PATH}"

RUN locale-gen it_IT.UTF-8
ENV LANG='it_IT.UTF-8' LANGUAGE='it_IT:en' LC_ALL='it_IT.UTF-8'

COPY ./configs/ /root/.config/nvim

# Install the installable (mason-lspconfig can't be installed ahead of time :( )
RUN sed -i 's/sync_install = false/sync_install = true/' /root/.config/nvim/lua/core/plugins/treesitter.lua \
	&& nvim --headless -c "autocmd User LazySync quitall" "+Lazy! sync" \
	&& nvim --headless +qa \
	&& sed -i 's/sync_install = true/sync_install = false/' /root/.config/nvim/lua/core/plugins/treesitter.lua

RUN mkdir /app && git config --global --add safe.directory /app

WORKDIR /app

CMD ["/bin/bash"]
