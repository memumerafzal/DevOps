#!/bin/bash

echo "🚀 Starting Codex environment setup..."

# --- Python Setup via pyenv ---
PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if ! command -v pyenv &>/dev/null; then
  echo "📦 Installing pyenv..."
  curl https://pyenv.run | bash
  export PATH="$HOME/.pyenv/shims:$HOME/.pyenv/bin:$HOME/.pyenv/plugins/python-build/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# --- Install Python 3.12.3 ---
if ! pyenv versions --bare | grep -q "3.12.3"; then
  echo "🔧 Installing Python 3.12.3..."
  pyenv install 3.12.3
fi

pyenv global 3.12.3
python --version

# --- Create Virtual Environment ---
python -m venv venv
source venv/bin/activate

# --- Upgrade pip ---
python -m pip install --upgrade pip

# --- Install Project Dependencies (requirements.txt) ---
echo "📦 Installing project dependencies..."
pip install openai flask pandas pandasql==0.7.3 pyodbc azure-ai-formrecognizer openpyxl tiktoken fuzzywuzzy pytest || echo "⚠️ Network error installing some packages — continuing..."

# --- Offline Install: flake8 & flask ---
if [ -d "/workspace/offline-wheels" ]; then
  echo "📦 Installing flake8 and flask from offline-wheels..."
  pip install --no-index --find-links=/workspace/offline-wheels flask flake8
else
  echo "⚠️ Offline wheels directory not found. Skipping offline install."
fi

# --- Confirm Setup ---
echo "✅ Python version: $(python --version)"
echo "✅ pip version: $(pip --version)"
echo "✅ Installed packages:"
pip list

echo "🎉 Environment setup complete!"
