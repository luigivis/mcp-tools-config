#!/bin/bash

show_menu() {
    echo ""
    echo "=========================================="
    echo "   MiniMax Tools Installer for OpenCode"
    echo "=========================================="
    echo ""
    echo "What would you like to install?"
    echo ""
    echo "  [1] Install MCP (for OpenCode AI tools)"
    echo "  [2] Install CLI (terminal tool)"
    echo "  [3] Install both MCP + CLI"
    echo "  [Q] Quit"
    echo ""
}

show_menu

read -p "Select option: " SELECTION

case $SELECTION in
    1) MODE="mcp" ;;
    2) MODE="cli" ;;
    3) MODE="both" ;;
    Q|q) exit 0 ;;
    *) echo "Invalid option"; exit 1 ;;
esac

echo ""
read -p "Enter your MiniMax API Key: " API_KEY

if [ -z "$API_KEY" ]; then
    echo "Error: API key cannot be empty"
    exit 1
fi

CONFIG_FILE="$HOME/.config/opencode/opencode.json"
MCP_MINIMAX_JSON="$HOME/mcp-minimax.json"

install_mcp() {
    echo ""
    echo "[*] Installing MCP..."
    
    MCP_CONFIG=$(cat <<MCP
{
  "MiniMax": {
    "type": "local",
    "command": ["uvx", "minimax-coding-plan-mcp", "-y"],
    "environment": {
      "MINIMAX_API_KEY": "$API_KEY",
      "MINIMAX_API_HOST": "https://api.minimax.io"
    },
    "enabled": true
  }
}
MCP
)

    python3 << PYEOF
import json
with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)
config['mcp'] = json.loads('''$MCP_CONFIG''')
with open('$CONFIG_FILE', 'w') as f:
    json.dump(config, f, indent=2)
PYEOF

    echo "$MCP_CONFIG" > "$MCP_MINIMAX_JSON"
    echo "[+] MCP installed"
    echo "    Config: $MCP_MINIMAX_JSON"
}

install_cli() {
    echo ""
    echo "[*] Installing mmx-cli..."
    
    if command -v npm &> /dev/null; then
        npm install -g mmx-cli 2>/dev/null || {
            echo "[!] npm install failed"
            echo "    Try manually: npm install -g mmx-cli"
        }
        echo "[+] CLI installed"
        echo "[*] Authenticating..."
        mmx auth login --api-key "$API_KEY" 2>/dev/null || {
            echo "[!] Auth failed"
            echo "    Run manually: mmx auth login --api-key YOUR_KEY"
        }
    else
        echo "[!] npm not found"
        echo "    Install Node.js first, then: npm install -g mmx-cli"
    fi
}

case $MODE in
    mcp) install_mcp ;;
    cli) install_cli ;;
    both) install_mcp; install_cli ;;
esac

echo ""
echo "=========================================="
echo "  Done!"
echo "=========================================="
echo ""
[ "$MODE" = "mcp" ] || [ "$MODE" = "both" ] && echo "  Restart OpenCode and type /mcp to verify"
[ "$MODE" = "cli" ] || [ "$MODE" = "both" ] && echo "  Run 'mmx quota' to check usage"
echo ""
