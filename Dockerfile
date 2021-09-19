FROM python:3.8.12

WORKDIR /workspace/
COPY . /workspace

RUN apt update && apt install -y \
    vim \
    zsh

RUN chsh -s /bin/zsh

# Install zinit
RUN chsh -s $(which zsh)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
RUN echo "zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'" >> ~/.zshrc
RUN echo "zinit light sindresorhus/pure" >> ~/.zshrc

RUN pip install --upgrade pip
RUN pip install poetry

# Install poetry as package maneger.
# RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
# RUN echo 'export PATH="$HOME/.poetry/bin:$PATH"' >> ~/.zshrc

# Install packages
RUN poetry config virtualenvs.create false \
    && poetry install
