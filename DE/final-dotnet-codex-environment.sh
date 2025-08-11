#!/bin/bash
set -euo pipefail

echo '📦 Installing .NET SDK 8.0...'
DOTNET_CHANNEL=8.0
INSTALL_DIR=/root/.dotnet
curl -sSL https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --channel "$DOTNET_CHANNEL" --install-dir "$INSTALL_DIR"

# Export for local session
export DOTNET_ROOT="$INSTALL_DIR"
export PATH="$INSTALL_DIR:$PATH"
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Make dotnet globally accessible (fix for Codex)
echo '🔗 Linking dotnet CLI to /usr/local/bin...'
ln -sf "$INSTALL_DIR/dotnet" /usr/local/bin/dotnet

# Verify installation
echo '✅ .NET SDK installed:'
dotnet --info

echo '🔐 Setting Telerik credentials...'
TELERIK="${TELERIK:-}"
TELERIK_API_KEY="${TELERIK_API_KEY:-}"

if [[ -z "$TELERIK" || -z "$TELERIK_API_KEY" ]]; then
  echo "❌ Telerik credentials not set. Use environment variables TELERIK and TELERIK_API_KEY."
  exit 1
fi

BASIC_AUTH=$(echo -n "${TELERIK}:${TELERIK_API_KEY}" | base64 | tr -d '\n')

echo '🧹 Clearing existing NuGet config...'
rm -f ~/.nuget/NuGet/NuGet.Config
dotnet nuget list source || true

echo '📝 Creating NuGet.config file...'
mkdir -p ~/.nuget/NuGet
cat > ~/.nuget/NuGet/NuGet.Config <<EOF
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <clear />
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" protocolVersion="3" />
    <add key="Telerik" value="https://nuget.telerik.com/v3/index.json" />
  </packageSources>
  <packageSourceCredentials>
    <Telerik>
      <add key="Username" value="${TELERIK}" />
      <add key="ClearTextPassword" value="${TELERIK_API_KEY}" />
    </Telerik>
  </packageSourceCredentials>
  <packageSourceMapping>
    <packageSource key="Telerik">
      <package pattern="Telerik.*" />
    </packageSource>
    <packageSource key="nuget.org">
      <package pattern="*" />
    </packageSource>
  </packageSourceMapping>
</configuration>
EOF

echo '✅ NuGet.Config created'

echo '🔍 Testing Telerik NuGet feed connectivity...'
echo "Testing v3 endpoint..."
TELERIK_V3_URL="https://nuget.telerik.com/v3/index.json"
HTTP_CODE_V3=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Basic ${BASIC_AUTH}" "${TELERIK_V3_URL}")
echo "Telerik v3 feed HTTP response code: ${HTTP_CODE_V3}"

echo "Testing v2 endpoint..."
TELERIK_V2_URL="https://nuget.telerik.com/nuget"
HTTP_CODE_V2=$(curl -s -o /dev/null -w "%{http_code}" -u "${TELERIK}:${TELERIK_API_KEY}" "${TELERIK_V2_URL}")
echo "Telerik v2 feed HTTP response code: ${HTTP_CODE_V2}"

if [ "$HTTP_CODE_V3" = "401" ] || [ "$HTTP_CODE_V2" = "401" ]; then
    echo "❌ ERROR: Authentication failed. The API key appears to be invalid."
    exit 1
elif [ "$HTTP_CODE_V3" != "200" ] && [ "$HTTP_CODE_V2" != "200" ]; then
    echo "⚠️  WARNING: Cannot connect to Telerik feeds (v3: ${HTTP_CODE_V3}, v2: ${HTTP_CODE_V2})"
    echo "This might be a temporary issue or network restriction."
fi

echo '🧹 Clearing NuGet caches...'
dotnet nuget locals all --clear

echo '📥 Restoring NuGet packages...'
dotnet restore DoctorsExpress-PHML.sln --configfile ~/.nuget/NuGet/NuGet.Config -v normal || {
    echo "❌ Package restore failed"
    echo ""
    echo "Troubleshooting steps:"
    echo "1. Verify your TELERIK and TELERIK_API_KEY environment variables."
    echo "2. Confirm your Telerik license includes the needed packages."
    echo "3. Visit https://www.telerik.com/account/your-products to check your subscription."
    echo ""
    echo "Testing package availability..."
    dotnet list package --source Telerik --include-prerelease | grep -i telerik || true
    exit 1
}

echo '🏗️ Building solution...'
dotnet build DoctorsExpress-PHML.sln --no-restore || {
    echo "❌ Build failed"
    exit 1
}

echo '✅ Build completed successfully!'
