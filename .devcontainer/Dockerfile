# Setting an R environment from scratch 
# Step 1 - Import base image
FROM ubuntu:22.04

# Step 2 - Set arguments and environment variables
# Define arguments
ARG VENV_NAME=VENV_NAME
ARG R_VERSION_MAJOR=4
ARG R_VERSION_MINOR=3
ARG R_VERSION_PATCH=1
ARG DEBIAN_FRONTEND=noninteractive
ARG CRAN_MIRROR=https://cran.rstudio.com/
# ARG QUARTO_VER="1.3.450"

# Define environment variables
ENV VENV_NAME=$VENV_NAME
ENV R_VERSION_MAJOR=$R_VERSION_MAJOR
ENV R_VERSION_MINOR=$R_VERSION_MINOR
ENV R_VERSION_PATCH=$R_VERSION_PATCH
# ENV QUARTO_VER=$QUARTO_VER
ENV CONFIGURE_OPTIONS="--with-cairo --with-jpeglib --enable-R-shlib --with-blas --with-lapack"
ENV TZ=UTC
ENV CRAN_MIRROR=$CRAN_MIRROR

# Step 3 - Install R dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils\
    gfortran \
    git \
    g++ \
    gnutls-dev \
    libreadline-dev \
    libx11-dev \
    libxt-dev \
    libpng-dev \
    libjpeg-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libudunits2-dev \
    libgdal-dev \
    libbz2-dev \
    libzstd-dev \
    liblzma-dev \
    libpcre2-dev \
    libxpm-dev \
    locales \
    openjdk-8-jdk \
    screen \
    texinfo \
    texlive \
    texlive-fonts-extra \
    vim \
    wget \
    xvfb \
    tzdata \
    sudo\
    jq\
    curl\
    fzf \
    fd-find \
    libgit2-dev \
    libmagick++-dev \
    make \
    tmux \
    python3-launchpadlib \
    python3.10-dev \
    python3.10-venv \
    python3-pip \
    lsof \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /test_install

RUN wget https://gnu.mirrors.hoobly.com/emacs/emacs-29.2.tar.gz && \
    tar zxvf emacs-29.2.tar.gz && \
    rm emacs-29.2.tar.gz

# RUN cd emacs-29.2
WORKDIR /test_install/emacs-29.2

RUN ./autogen.sh && \
    ./configure --with-x-toolkit=no && \
    make -j$(nproc) && \
    make install
# Step 4 - Install R
# RUN mkdir r_install
# WORKDIR r_install
WORKDIR /root
RUN wget https://cran.rstudio.com/src/base/R-${R_VERSION_MAJOR}/R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz && \
    tar zxvf R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz && \
    rm R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz

WORKDIR /root/R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}
# RUN cd R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}
RUN ./configure ${CONFIGURE_OPTIONS} && \
    make && \
    make install

RUN locale-gen en_US.UTF-8

# WORKDIR ~/
# install emacs

WORKDIR /root
# RUN git clone -b macbook_personal --single-branch https://github.com/Yousuf28/doomemacs_config.git

RUN git clone --depth 1 https://github.com/Yousuf28/doomemacs /root/.config/emacs && \
    export PATH=/root/.config/emacs/bin:$PATH
WORKDIR /root/.config/emacs/bin
RUN ./doom install --config --no-env --no-fonts



WORKDIR ~/
RUN mkdir settings
# WORKDIR /root/settings
COPY packages.json install_packages.R requirements.txt install_quarto.sh ./settings/
RUN Rscript ./settings/install_packages.R

RUN python3 -m venv /opt/$VENV_NAME  \
    && export PATH=/opt/$VENV_NAME/bin:$PATH \
    && echo "source /opt/$VENV_NAME/bin/activate" >> ~/.bashrc \
    && echo "alias r='radian'" >> ~/.bashrc

RUN R -e 'remotes::install_github("sbutler5/SENDsanitizer@package")'

RUN pip3 install -r ./settings/requirements.txt

WORKDIR /root

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN wget -O .tmux.conf https://raw.githubusercontent.com/Yousuf28/ds_nix/main/tmux.conf
RUN wget -O .vimrc https://raw.githubusercontent.com/Yousuf28/ds_nix/main/vimrc


# Installing Quarto
# RUN bash ./settings/install_quarto.sh $QUARTO_VER

# Step 5 - Set Python Environment and install radian

# COPY init.R /root/.vscode-R/init.R
# COPY init.R /root/.vscode-server/extensions/reditorsupport.r-2.8.2/R/session/init.R
