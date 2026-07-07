# Security Policy

## Reporting a vulnerability

If you believe you have found a security vulnerability in the Zillow MCP server
(`https://api.zillapi.com/mcp`), the Zillapi API, or anything in this
repository, please report it privately:

- **Email:** [hello@zillapi.com](mailto:hello@zillapi.com) — subject line
  starting with `[SECURITY]`.

Please include a description of the issue, steps to reproduce, and any
relevant request/response examples (redact your API key).

We will acknowledge reports promptly, keep you informed of progress, and
credit reporters who wish to be named once a fix is released.

## Scope notes

- The hosted MCP endpoint authenticates every `tools/call` with the same
  key-hash verification as the REST API; API keys are stored hashed.
- Never share a `zk_` API key in issues, discussions, or pull requests. If a
  key is exposed, revoke it immediately from your dashboard at
  [zillapi.com](https://zillapi.com) and mint a new one.

## Supported versions

The MCP server is a hosted service — all users are always on the latest
version. This repository contains public documentation and registry metadata
only.
