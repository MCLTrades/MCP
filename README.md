# Magic MCP

This repository is configured to use the [21st.dev Magic MCP](https://github.com/21st-dev/magic-mcp) server via project-scoped configuration in [`.mcp.json`](./.mcp.json).

Magic MCP is an AI agent that generates UI components ("Magic Agent"). Once installed, you can ask your MCP-enabled client (Claude Code, Cursor, Windsurf, Cline, etc.) to build UI and it will fetch/generate components for you.

## Prerequisites

- [Node.js](https://nodejs.org/) (latest LTS recommended) — provides `npx`
- A Magic API key from the [21st.dev Magic Console](https://21st.dev/magic/console)

## Setup

The server is defined in `.mcp.json`:

```json
{
  "mcpServers": {
    "@21st-dev/magic": {
      "command": "npx",
      "args": ["-y", "@21st-dev/magic@latest"],
      "env": {
        "API_KEY": "${MAGIC_MCP_API_KEY}"
      }
    }
  }
}
```

The API key is **not** committed to the repository. Instead it is read from the
`MAGIC_MCP_API_KEY` environment variable, which `.mcp.json` expands into the
server's `API_KEY` at launch.

1. Export your key before starting your MCP client:

   ```bash
   export MAGIC_MCP_API_KEY="your-api-key"
   ```

2. Start (or restart) your MCP client in this directory. Claude Code will pick
   up `.mcp.json` automatically and prompt you to approve the server on first
   use.

### Alternative: automated CLI install

The Magic CLI can also write the config for you:

```bash
npx @21st-dev/cli@latest install claude --api-key <your-api-key>
```

Supported clients: `cursor`, `windsurf`, `cline`, `claude`.

## Security

Do not hardcode your API key in `.mcp.json` or commit it to version control.
Keep it in the `MAGIC_MCP_API_KEY` environment variable (or your shell/secret
manager) as shown above.
