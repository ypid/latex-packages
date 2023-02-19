# SPDX-FileCopyrightText: 2023 Robin Schneider <ypid@riseup.net>
#
# SPDX-License-Identifier: CC0-1.0

# https://gitlab.com/islandoftex/images/texlive/container_registry/573747?orderBy=NAME&sort=asc&search[]=TL2022-2023-02&search[]=
# FROM registry.gitlab.com/islandoftex/images/texlive:TL2022-2023-02-05-full

# RUN apt-get update && \
    # DEBIAN_FRONTEND=noninteractive apt-get -qq -o=Dpkg::Use-Pty=0 install sudo make chktex lacheck git python3 pipx reuse

# RUN tlmgr remove --force doclicense calcage counttexruns fnumprint

# ARG USER_UID
# ARG USER_GID

# RUN groupadd --gid "$USER_GID" user \
    # && useradd -G plugdev,sudo -ms /bin/bash --uid "$USER_UID" --gid "$USER_GID" user \
    # && chown -R user:user /home/user \
    # && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# WORKDIR /home/user/latex-packages

# USER user

# # Include font name DB in Docker image to allow containers to reuse it.
# RUN luaotfload-tool --update

FROM debian:bullseye-slim
