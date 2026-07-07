# Zillow MCP Server — Property Data, Zestimates & Listings for AI Agents

Zillow MCP gives AI agents one-call access to Zillow property data — Zestimates, listings, photos, schools, taxes, and full price history — across 160M+ U.S. homes.

Hosted at **`https://api.zillapi.com/mcp`** — nothing to install or run. Connect your MCP client, authenticate, and your agent pulls live property data mid-conversation. [Zillapi](https://zillapi.com) is an independent service for Zillow-sourced data — not affiliated with Zillow. [Start free — 100 credits, no card.](https://zillapi.com/signup)

- **Endpoint:** `https://api.zillapi.com/mcp`
- **Transport:** Streamable HTTP (MCP protocol `2025-06-18`)
- **Auth:** OAuth 2.1 with Dynamic Client Registration (connector UIs like Claude and ChatGPT discover it automatically), or a `zk_` API key as a Bearer header — both use the same underlying key
- **Server card:** [`https://zillapi.com/.well-known/mcp/server-card.json`](https://zillapi.com/.well-known/mcp/server-card.json)

## What you can do

| Tool | What it returns | Key params |
|---|---|---|
| `lookup_property_by_address` | Full Zillow property record for a U.S. address — price, Zestimate, photos, schools, taxes, agent contact, price history (3 credits) | `address` (street, city, state, ZIP) |
| `lookup_property_by_zpid` | Full property record by Zillow property id; cache-served when fresh (24 h), 1 credit on a cache miss | `zpid` |
| `get_zestimate` | Zillow's automated valuation (Zestimate) + rent Zestimate for a property | `zpid` |
| `search_listings` | For-sale, for-rent, or sold listings inside a geographic bounding box, with bedroom/price filters (1 credit per result, up to 50) | `bbox` (`west,south,east,north`), `status` (`for_sale` \| `for_rent` \| `sold`), `beds_min`, `price_max` |

## How to connect

Clients with a connectors UI (Claude Desktop, ChatGPT) authenticate via OAuth when prompted — **no API key needed.** For key-based clients (Cursor, Cline, VS Code), get a free API key (100 credits, no card) at [zillapi.com/signup](https://zillapi.com/signup).

### Claude Desktop

Settings → Connectors → **Add custom connector** → paste `https://api.zillapi.com/mcp`. Claude runs the OAuth sign-in for you — **no API key needed.**

Prefer a key, or running headless? Add it to `claude_desktop_config.json` instead:

```json
{
  "mcpServers": {
    "zillapi": {
      "transport": "streamable-http",
      "url": "https://api.zillapi.com/mcp",
      "headers": {
        "Authorization": "Bearer zk_YOUR_KEY_HERE"
      }
    }
  }
}
```

### Claude Code

```bash
claude mcp add --transport http zillapi https://api.zillapi.com/mcp \
  --header "Authorization: Bearer zk_YOUR_KEY_HERE"
```

### ChatGPT

1. Enable **Developer Mode** (Settings → Apps & Connectors → Advanced).
2. **Settings → Connectors → Add MCP server.**
3. Paste `https://api.zillapi.com/mcp` and complete the OAuth sign-in when prompted.

### Cursor

Add to `.cursor/mcp.json` (project) or `~/.cursor/mcp.json` (global):

```json
{
  "mcpServers": {
    "zillapi": {
      "url": "https://api.zillapi.com/mcp",
      "headers": {
        "Authorization": "Bearer zk_YOUR_KEY_HERE"
      }
    }
  }
}
```

### Cline

MCP Servers → Remote Servers → add `https://api.zillapi.com/mcp` with the `Authorization: Bearer zk_...` header (or edit `cline_mcp_settings.json` with the same shape as the Cursor block above).

### VS Code (GitHub Copilot agent mode)

```bash
code --add-mcp '{"name":"zillapi","type":"http","url":"https://api.zillapi.com/mcp","headers":{"Authorization":"Bearer zk_YOUR_KEY_HERE"}}'
```

## Example call

A prompt like *“What's the Zestimate for 17 Zelma Dr, Greenville SC?”* becomes a `lookup_property_by_address` tool call:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "lookup_property_by_address",
    "arguments": { "address": "17 Zelma Dr, Greenville, SC 29617" }
  }
}
```

and returns structured JSON the model can act on directly (real response, trimmed):

```json
{
  "data": {
    "zpid": "11026031",
    "address": { "streetAddress": "17 Zelma Dr", "city": "Greenville", "state": "SC", "zipcode": "29617" },
    "price": 415000,
    "zestimate": 481100,
    "rentZestimate": 2143,
    "bedrooms": 4,
    "bathrooms": 3,
    "livingArea": 1842,
    "homeStatus": "SOLD"
  },
  "request_id": "fb1f868e-2a10-49d8-ae01-1713ef5391e7"
}
```

The same lookup by id: `get_zestimate` with `{"zpid": "2064142765"}` returns `{"zestimate": 1070100, "rent_zestimate": 8380, "last_sold_price": 980000, "currency": "USD"}`.

## Data you get

| Field group | Examples |
|---|---|
| Valuation | Zestimate, rent Zestimate, tax-assessed value, last sold price |
| Core facts | beds, baths, living area (sqft), lot size, year built, home type, status |
| Price history | full listing/sale price timeline per property |
| Tax history | assessed values and tax amounts by year |
| Schools | assigned schools with ratings and distance |
| Media | photo URLs (full resolution) |
| Contact | listing agent/broker name and contact where published |
| Everything else | `resoFacts` and the rest of the 300+ fields Zillow publishes per home |

Coverage: 160M+ U.S. parcels, residential focus. Responses are JSON (CSV/NDJSON available on the REST API).

## Free tier & pricing

Every account starts with **100 free credits at signup — no card required**. Most tool calls cost 1 credit per record returned; address lookups cost 3; failed calls are always free. Paid usage is credit-based — monthly and annual plans, or top-ups from $4 per 1,000 credits. Full breakdown: [zillapi.com/pricing](https://zillapi.com/pricing/).

## REST API, docs & spec

The same data is available as a plain REST API (`https://api.zillapi.com/v1`) with an [OpenAPI 3.1 spec](https://zillapi.com/openapi.json), [quickstart](https://zillapi.com/quickstart/), and [full API reference](https://zillapi.com/api/properties/). Guides: [Claude Desktop](https://zillapi.com/blog/zillow-mcp-claude-desktop/) · [Claude Code](https://zillapi.com/blog/zillow-mcp-claude-code/) · [Cursor](https://zillapi.com/blog/zillow-mcp-cursor/) · [For AI agents](https://zillapi.com/ai-agents/).

## FAQ

**Is there a public Zillow API in 2026?**
Not an open one — Zillow retired its public API (ZWSID) in 2021, and official access now runs through Bridge Interactive, which is MLS-gated. Zillow MCP provides same-day, self-serve access to Zillow-sourced property data through the Model Context Protocol, with a free tier and no approval process.

**What is a Zillow MCP?**
A Zillow MCP is a Model Context Protocol server that exposes Zillow property data as tools an AI agent can call — property lookup by address or zpid, Zestimates, and listing search — so assistants like Claude, ChatGPT, and Cursor can fetch live U.S. property data mid-conversation.

**How do I add it to Claude Desktop, Claude Code, or ChatGPT?**
Claude Desktop: Settings → Connectors → Add custom connector → paste `https://api.zillapi.com/mcp`. Claude Code: `claude mcp add --transport http zillapi https://api.zillapi.com/mcp --header "Authorization: Bearer zk_YOUR_KEY"`. ChatGPT: enable Developer Mode, then Settings → Connectors → Add MCP server → paste the URL and complete the OAuth prompt. See [How to connect](#how-to-connect) for copy-paste blocks.

**How much does it cost?**
100 free credits at signup with no card. After that it's credit-based — monthly/annual plans or top-ups from $4 per 1,000 credits. Most calls are 1 credit per record; address lookups are 3 credits; failed calls are free.

**Is this affiliated with Zillow?**
No. Zillapi is an independent service and is not affiliated with, endorsed by, or sponsored by Zillow Group, Inc. "Zillow" and "Zestimate" are trademarks of Zillow Group, Inc., used here descriptively to refer to those services.

## License

MIT — see [LICENSE](LICENSE). The MCP server itself is a hosted service; this repository contains its public documentation and registry metadata.
