#!/bin/bash

echo "🔧 Starting environment setup..."

# --- Python via pyenv ---
PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if ! command -v pyenv &>/dev/null; then
  curl https://pyenv.run | bash
  export PATH="$HOME/.pyenv/shims:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Install Python 3.12.3 if needed
if ! pyenv versions --bare | grep -q "3.12.3"; then
  pyenv install 3.12.3
fi

pyenv global 3.12.3

# --- venv ---
python -m venv venv
source venv/bin/activate
python -m pip install --upgrade pip

# --- Install dependencies from updated requirements.txt ---
if [ -f requirements.txt ]; then
  pip install -r requirements.txt || echo "⚠️ Some installs failed due to network issues"
fi

# --- Install flask & flake8 from offline cache ---
if [ -d "/workspace/offline-wheels" ]; then
  pip install --no-index --find-links=/workspace/offline-wheels flask flake8 flask_cors python-Levenshtein
fi

# --- Install ODBC Driver 17 (Ubuntu) ---
if [ -f "/etc/os-release" ] && grep -qi ubuntu /etc/os-release; then
  echo "📦 Installing Microsoft ODBC Driver 17 for SQL Server..."
  curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
  curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
  apt-get update
  ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev
else
  echo "⚠️ Skipping ODBC install (non-Ubuntu or restricted container)"
fi

echo "✅ Environment setup complete."
