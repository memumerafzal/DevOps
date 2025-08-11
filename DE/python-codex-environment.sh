#!/bin/bash

# Set Python version
PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Install pyenv if not installed
if ! command -v pyenv &>/dev/null; then
  curl https://pyenv.run | bash
  export PATH="$HOME/.pyenv/shims:$HOME/.pyenv/bin:$HOME/.pyenv/plugins/python-build/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Install Python 3.12.10 if not present
if ! pyenv versions --bare | grep -q "3.12.10"; then
  pyenv install 3.12.10
fi

pyenv global 3.12.10
python --version

# Create virtual environment
python -m venv venv
source venv/bin/activate

# Upgrade pip
python -m pip install --upgrade pip

# Install project dependencies + pytest
pip install openai flask pandas pandasql==0.7.3 pyodbc azure-ai-formrecognizer openpyxl tiktoken fuzzywuzzy pytest flake8

echo "✅ Codex environment ready with Python 3.12.10 and all dependencies "
