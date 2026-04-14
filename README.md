# MiniMax Tools Installer
Installer script for MiniMax MCP and CLI tools.
## What is MiniMax?
MiniMax provides AI tools for text, images, video, speech, and music generation. This installer sets up either or both of:
- **MCP (Model Context Protocol)**: Tools for AI coding assistants (OpenCode, Claude Code, Cursor, etc.)
- **CLI**: Terminal interface for direct API access
## Requirements
- **MCP**: OpenCode, `uvx` (installed via `uv`)
- **CLI**: Node.js 18+, `npm`
## Installation
1. Clone or download this repository or paste:
```bash
curl -fsSL https://raw.githubusercontent.com/luigivis/mcp-tools-config/refs/heads/main/install-minimax-mcp.sh | bash
```
2. Make the script executable:
```bash
chmod +x install-minimax-mcp.sh
```
## Usage
Run the installer:
```bash
./install-minimax-mcp.sh
```
The script will prompt you to:
1. Select what to install (MCP, CLI, or both)
2. Enter your MiniMax API key
### Getting Your API Key
Sign up at [platform.minimax.io/subscribe/token-plan](https://platform.minimax.io/subscribe/token-plan)
## MCP Usage
### OpenCode
After installation, edit `~/.config/opencode/opencode.json` and update the `MINIMAX_API_KEY` value:
```json
{
  "mcp": {
    "MiniMax": {
      "type": "local",
      "command": ["uvx", "minimax-coding-plan-mcp", "-y"],
      "environment": {
        "MINIMAX_API_KEY": "YOUR_ACTUAL_API_KEY",
        "MINIMAX_API_HOST": "https://api.minimax.io"
      },
      "enabled": true
    }
  }
}
```
Restart OpenCode and type `/mcp` to verify MiniMax is connected.
### Claude Code
```bash
claude mcp add -s user MiniMax --env MINIMAX_API_KEY=YOUR_API_KEY --env MINIMAX_API_HOST=https://api.minimax.io -- uvx minimax-coding-plan-mcp -y
```
### Cursor
Add to `mcp.json`:
```json
{
  "mcpServers": {
    "MiniMax": {
      "command": "uvx",
      "args": ["minimax-coding-plan-mcp"],
      "env": {
        "MINIMAX_API_KEY": "YOUR_API_KEY",
        "MINIMAX_API_HOST": "https://api.minimax.io"
      }
    }
  }
}
```
### Windsurf
Refer to [Windsurf setup guide](https://platform.minimax.io/docs/ai-tools/windsurf.md)
### VS Code (with Continue extension)
Add to `.continue/config.json`:
```json
{
  "mcpServers": {
    "MiniMax": {
      "command": "uvx",
      "args": ["minimax-coding-plan-mcp"],
      "env": {
        "MINIMAX_API_KEY": "YOUR_API_KEY",
        "MINIMAX_API_HOST": "https://api.minimax.io"
      }
    }
  }
}
```
## CLI Usage
After installation and authentication:
```bash
# Check quota
mmx quota
# Text chat
mmx text chat --message "Hello!"
# Generate image
mmx image "A sunset over mountains"
# Generate speech
mmx speech synthesize --text "Hello!" --out hello.mp3
# Generate video
mmx video generate --prompt "Ocean waves"
# Generate music
mmx music generate --prompt "Upbeat pop" --out song.mp3
# Web search
mmx search "MiniMax latest news"
# Vision (understand images)
mmx vision photo.jpg
```
## Available MCP Tools
- `web_search` - Search the web
- `understand_image` - Analyze images (JPEG, PNG, WebP, max 20MB)
## Documentation
- [MiniMax Platform Docs](https://platform.minimax.io/docs)
- [Token Plan MCP Guide](https://platform.minimax.io/docs/guides/token-plan-mcp-guide.md)
- [OpenCode Integration](https://platform.minimax.io/docs/token-plan/opencode.md)
- [CLI GitHub Repo](https://github.com/MiniMax-AI/cli)
