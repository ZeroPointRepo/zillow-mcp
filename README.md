<!-- mcp-name: com.zillapi/zillow-mcp -->

<p align="center">
  <a href="https://zillapi.com">
    <img src="public/brand/logo-512.png" width="160" height="160" alt="Zillapi" />
  </a>
</p>

<h1 align="center">Zillow MCP Server — Property Data, Zestimates & Listings for AI Agents</h1>

<p align="center">
  <b>Run comps, check home values, and scan listings by just asking your AI — live Zillow data on 160M+ U.S. homes. Try for free.</b><br/>
  Four tools — property lookup by address, lookup by zpid, Zestimates, and listing search — for Claude, ChatGPT, Hermes Agent, OpenClaw, Cursor, Claude Code, and any MCP client.
</p>

<p align="center">
  <a href="https://cursor.com/en/install-mcp?name=zillapi&config=eyJ1cmwiOiJodHRwczovL2FwaS56aWxsYXBpLmNvbS9tY3AifQ=="><img alt="Install in Cursor" src="https://img.shields.io/badge/Cursor-Install_MCP-000000?style=for-the-badge&logo=cursor&logoColor=white"/></a>
  <a href="https://insiders.vscode.dev/redirect?url=vscode%3Amcp%2Finstall%3F%7B%22name%22%3A%22zillapi%22%2C%22url%22%3A%22https%3A%2F%2Fapi.zillapi.com%2Fmcp%22%7D"><img alt="Install in VS Code" src="https://img.shields.io/badge/VS_Code-Install_MCP-0098FF?style=for-the-badge&logo=visualstudiocode&logoColor=white"/></a>
</p>

<p align="center">
  <a href="https://zillapi.com"><img src="https://img.shields.io/badge/Website-zillapi.com-0061FF?style=for-the-badge" alt="Website"/></a>
  <a href="https://zillapi.com/api/properties/"><img src="https://img.shields.io/badge/Docs-API_Reference-06B6D4?style=for-the-badge&logo=readthedocs&logoColor=white" alt="Docs"/></a>
  <a href="https://zillapi.com/openapi.json"><img src="https://img.shields.io/badge/OpenAPI-3.1_Spec-85EA2D?style=for-the-badge&logo=openapiinitiative&logoColor=white" alt="OpenAPI"/></a>
  <a href="./LICENSE"><img src="https://img.shields.io/badge/License-MIT-4CAF50?style=for-the-badge" alt="MIT License"/></a>
</p>

> **160M+ U.S. properties · 300+ fields per home · hosted REST + MCP · free tier, no card**
> [Zillapi](https://zillapi.com) is an independent service for Zillow-sourced data — not affiliated with Zillow.

---

## Why Zillow MCP

You run comps, check what homes are worth, and track listings all day. Zillow MCP puts that data inside the AI you already talk to.

**Connect once, then just ask.** Add Zillow MCP to Claude, ChatGPT, Cursor, or any MCP client a single time — and your AI assistant can pull live Zillow property data (full property records, Zestimates, and listings) right in the conversation. No code, no repeated setup.

Ask for comps on a subject property. Check a flip's numbers against its asking price. Pull rent estimates for a cash-flow check. Or just ask what a home is worth — Zestimate, taxes, schools, and full price history come back in seconds.

**Quick taste:**

```txt
Find 3-bed homes for sale under $600k in Greenville SC,
pull the full record for the most promising one,
and check how its Zestimate compares to the asking price.
```

That single prompt uses 3 of the 4 tools — `search_listings`, `lookup_property_by_zpid`, `get_zestimate` — without you writing a line of code.

---

## Quick Install

> **Requirements:**
>
> - A Zillapi account ([sign up free](https://zillapi.com/signup) — 100 credits free, no card)
> - An API key (`zk_...`) from your dashboard **OR** just use OAuth (Claude, ChatGPT, Hermes Agent, OpenClaw — no key handling)

> **Recommended: add a rule to auto-invoke Zillow MCP**
>
> Add this rule to your AI client so you don't have to ask explicitly:
>
> ```txt
> When I mention a U.S. property address, a Zillow link, or ask about home
> values, listings, or comps, automatically use the zillapi MCP tools to
> fetch real property data before answering.
> ```

<details>
<summary><b>Install in Claude (Desktop & Web) — Recommended</b></summary>

**Zillow MCP works with Claude Desktop and Claude Web.**

Settings → Connectors → **Add custom connector** → paste:

```
https://api.zillapi.com/mcp
```

Claude runs the OAuth sign-in for you — **no API key needed.**

Prefer a key, or running headless? Add to `claude_desktop_config.json` instead:

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

</details>

<details>
<summary><b>Install in Claude Code (CLI)</b></summary>

**Zillow MCP works with Claude Code.**

```bash
claude mcp add --transport http zillapi https://api.zillapi.com/mcp \
  --header "Authorization: Bearer zk_YOUR_KEY_HERE"
```

</details>

<details>
<summary><b>Install in ChatGPT</b></summary>

**Zillow MCP works with ChatGPT (Developer Mode).**

1. Enable **Developer Mode**: Settings → Apps & Connectors → Advanced settings.
2. Go to **Settings → Connectors → Add MCP server** (Create in the Connectors panel).
3. Paste the server URL:

```
https://api.zillapi.com/mcp
```

4. Complete the OAuth sign-in when prompted — **no API key needed.**

</details>

<details>
<summary><b>Install in Hermes Agent</b></summary>

**Zillow MCP works with Hermes Agent.**

Add to `~/.hermes/config.yaml` under `mcp_servers` — with OAuth (no key handling):

```yaml
mcp_servers:
  zillapi:
    url: "https://api.zillapi.com/mcp"
    auth: oauth
```

Or with an API key:

```yaml
mcp_servers:
  zillapi:
    url: "https://api.zillapi.com/mcp"
    headers:
      Authorization: "Bearer zk_YOUR_KEY_HERE"
```

With `auth: oauth`, Hermes runs the MCP OAuth 2.1 flow (metadata discovery + dynamic client registration) automatically — this server supports it out of the box.

</details>

<details>
<summary><b>Install in OpenClaw</b></summary>

**Zillow MCP works with OpenClaw.**

With OAuth (no key handling):

```bash
openclaw mcp add zillapi --url https://api.zillapi.com/mcp --transport streamable-http --auth oauth
openclaw mcp login zillapi
```

Or with an API key:

```bash
openclaw mcp set zillapi '{"url":"https://api.zillapi.com/mcp","transport":"streamable-http","headers":{"Authorization":"Bearer zk_YOUR_KEY"}}'
```

Both write to `~/.openclaw/openclaw.json` under `mcp.servers`:

```json
{
  "mcp": {
    "servers": {
      "zillapi": {
        "url": "https://api.zillapi.com/mcp",
        "transport": "streamable-http",
        "auth": "oauth"
      }
    }
  }
}
```

Prefer skills over MCP? Zillapi is also available as an OpenClaw-ready agent **skill** — grab it at [ZeroPointRepo/zillow-skills](https://github.com/ZeroPointRepo/zillow-skills).

</details>

<details>
<summary><b>Install in Cursor (One-Click / Manual)</b></summary>

[<img alt="Install in Cursor" src="https://img.shields.io/badge/Cursor-Install_MCP-000000?style=flat-square&logo=cursor&logoColor=white"/>](https://cursor.com/en/install-mcp?name=zillapi&config=eyJ1cmwiOiJodHRwczovL2FwaS56aWxsYXBpLmNvbS9tY3AifQ==)

Or manually — add to `.cursor/mcp.json` (project) or `~/.cursor/mcp.json` (global):

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

</details>

<details>
<summary><b>Install in VS Code (GitHub Copilot agent mode)</b></summary>

[<img alt="Install in VS Code" src="https://img.shields.io/badge/VS_Code-Install_MCP-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white"/>](https://insiders.vscode.dev/redirect?url=vscode%3Amcp%2Finstall%3F%7B%22name%22%3A%22zillapi%22%2C%22url%22%3A%22https%3A%2F%2Fapi.zillapi.com%2Fmcp%22%7D)

Or from the command line:

```bash
code --add-mcp '{"name":"zillapi","type":"http","url":"https://api.zillapi.com/mcp","headers":{"Authorization":"Bearer zk_YOUR_KEY_HERE"}}'
```

</details>

<details>
<summary><b>Install in Cline</b></summary>

```json
{
  "mcpServers": {
    "zillapi": {
      "url": "https://api.zillapi.com/mcp",
      "type": "streamableHttp",
      "headers": {
        "Authorization": "Bearer zk_YOUR_KEY_HERE"
      }
    }
  }
}
```

</details>

<details>
<summary><b>Install in Windsurf</b></summary>

Add to `~/.codeium/windsurf/mcp_config.json`:

```json
{
  "mcpServers": {
    "zillapi": {
      "serverUrl": "https://api.zillapi.com/mcp",
      "headers": {
        "Authorization": "Bearer zk_YOUR_KEY_HERE"
      }
    }
  }
}
```

</details>

<details>
<summary><b>Install in Zed</b></summary>

In Zed `settings.json`:

```json
{
  "context_servers": {
    "zillapi": {
      "source": "remote",
      "url": "https://api.zillapi.com/mcp",
      "headers": {
        "Authorization": "Bearer zk_YOUR_KEY_HERE"
      }
    }
  }
}
```

</details>

<details>
<summary><b>Install in Roo Code</b></summary>

```json
{
  "mcpServers": {
    "zillapi": {
      "type": "streamable-http",
      "url": "https://api.zillapi.com/mcp",
      "headers": {
        "Authorization": "Bearer zk_YOUR_KEY_HERE"
      }
    }
  }
}
```

</details>

<details>
<summary><b>Install in LM Studio</b></summary>

In `mcp.json`:

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

</details>

<details>
<summary><b>Install in Gemini CLI</b></summary>

In `~/.gemini/settings.json`:

```json
{
  "mcpServers": {
    "zillapi": {
      "httpUrl": "https://api.zillapi.com/mcp",
      "headers": {
        "Authorization": "Bearer zk_YOUR_KEY_HERE"
      }
    }
  }
}
```

</details>

<details>
<summary><b>Install in JetBrains AI Assistant</b></summary>

In Settings → Tools → AI Assistant → MCP:

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

</details>

<details>
<summary><b>Install in OpenAI Agent Builder / Agents SDK</b></summary>

Add the server as a hosted MCP tool with the URL `https://api.zillapi.com/mcp` and an `Authorization: Bearer zk_YOUR_KEY_HERE` header (or let end users OAuth). Any framework that speaks streamable-HTTP MCP works the same way.

</details>

---

## Authentication

Two ways in — both end at the same account and credits:

- **OAuth 2.1 (recommended for Claude, ChatGPT, Hermes Agent & OpenClaw):** paste the endpoint (or set `auth: oauth`) and sign in when prompted. The server implements Dynamic Client Registration, so DCR-aware clients discover everything automatically — you never touch a key.
- **API key (`zk_...`):** for key-based clients (Cursor, VS Code, Cline, scripts). Get one free at [zillapi.com/signup](https://zillapi.com/signup) and send it as `Authorization: Bearer zk_...`.

> **Security note:** treat `zk_` keys like passwords — never commit them to a repo or paste them into shared configs. If a key leaks, revoke it in your dashboard and mint a new one.

---

## Available Tools

### 1. `lookup_property_by_address`

Full Zillow property record for a U.S. address — price, Zestimate, photos, schools, taxes, agent contact, and price history. **3 credits.**

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| `address` | string | *required* | Full street address with city, state, and ZIP. Example: `17 Zelma Dr, Greenville, SC 29617` |

Real response (trimmed):

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

### 2. `lookup_property_by_zpid`

Full property record by Zillow property id. **1 credit.**

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| `zpid` | string | *required* | Numeric Zillow property id, e.g. `11026031` |

### 3. `get_zestimate`

Zillow's automated valuation (Zestimate) and rent Zestimate for a property.

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| `zpid` | string | *required* | Numeric Zillow property id |

Real response:

```json
{
  "data": {
    "zestimate": 1070100,
    "rent_zestimate": 8380,
    "tax_assessed_value": null,
    "last_sold_price": 980000,
    "currency": "USD"
  },
  "request_id": "b2a21325-c135-40ad-9473-eeaa185b30f5"
}
```

### 4. `search_listings`

For-sale, for-rent, or sold listings inside a geographic bounding box, with optional bedroom and price filters. **1 credit per result, up to 50 per call.**

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| `bbox` | string | *required* | Bounding box as `west,south,east,north` decimal lat/lon. Example: `-83.0,34.7,-82.0,35.0` |
| `status` | string | *required* | `for_sale` \| `for_rent` \| `sold` |
| `beds_min` | integer | — | Minimum bedrooms |
| `price_max` | integer | — | Price ceiling in USD |

---

## Use Cases & Prompts

| Use case | Example prompt |
| --- | --- |
| **Comps / quick CMA** | "Run comps for 17 Zelma Dr, Greenville SC — recently sold 3-beds nearby, sale price vs Zestimate, and price per sqft." |
| **Flip / ARV check** | "This one's listed at $415k. Pull the full record and Zestimate — how much margin is there if it rehabs to the neighborhood's price per sqft?" |
| **Rental analysis** | "Get rent Zestimates for these five addresses and rank them by gross yield against asking price." |
| **Market scan** | "Scan for-sale homes under $500k with 3+ beds in this part of Austin — summarize price per sqft and days on market." |
| **Lead gen brief** | "Pull taxes, price history, and schools for this address and draft a one-paragraph brief for my client." |
| **Buyer / seller check** | "What's this home worth? Zestimate vs asking price, plus property taxes and school ratings." |

---

## Pricing & Rate Limits

| Plan | Price | Credits | Rate limit |
| --- | --- | --- | --- |
| **Free** | $0 — no card required | 100 at signup | 20 req/min |
| **Monthly** | see [zillapi.com/pricing](https://zillapi.com/pricing/) | monthly credit allowance | 200 req/min |
| **Annual** | see [zillapi.com/pricing](https://zillapi.com/pricing/) | granted upfront — best per-credit rate | 300 req/min |

- Most calls cost **1 credit per record returned**; `lookup_property_by_address` costs **3 credits**; failed calls are **free**.
- Top-ups from **$4 per 1,000 credits** (paid plans).
- [View pricing](https://zillapi.com/pricing/) · [Sign up free](https://zillapi.com/signup)

---

## Troubleshooting

<details>
<summary><b>Authentication errors (401)</b></summary>

- Verify your API key starts with `zk_`
- Check for extra spaces when copying the key or the endpoint URL
- Ensure the key hasn't been revoked in your Zillapi dashboard
- If using OAuth, try removing and re-adding the connector to re-authorize
</details>

<details>
<summary><b>No credits (402 out_of_credits)</b></summary>

- Check your credit balance in your Zillapi dashboard
- On a paid plan, buy a top-up pack; on the free tier, upgrade at [zillapi.com/pricing](https://zillapi.com/pricing/)
- Failed calls are never charged — a 402 means the account balance is empty, not that you were billed
</details>

<details>
<summary><b>Property not found (404)</b></summary>

- For address lookups, include city, state, and ZIP (e.g. `17 Zelma Dr, Greenville, SC 29617`)
- Verify the zpid is the numeric id from a `zillow.com/homedetails/..._zpid/` URL
- Some parcels (new construction, unlisted land) may not have a Zillow record yet
</details>

<details>
<summary><b>Rate limiting (429 rate_limited)</b></summary>

- Respect the `Retry-After` header and back off exponentially
- The `error.code` is a stable string (`rate_limited`) — detect it without parsing prose
- Rate-limited calls are not charged; upgrade your plan for higher per-minute limits
</details>

<details>
<summary><b>OAuth issues</b></summary>

- Clear browser cookies and retry the connector authorization
- Ensure popup blockers aren't stopping the sign-in window
- OAuth discovery starts from the server's 401 response — if a client can't connect, confirm it supports MCP OAuth 2.1 / DCR, or fall back to an API key
</details>

---

## Also available as a REST API

Building an app instead of an agent? The same backend ships as a JSON REST API.

|                 | MCP                    | REST API |
| --------------- | ---------------------- | -------- |
| **Best for**    | AI assistants & agents | Apps & backend services |
| **Setup**       | Add a URL              | Code integration |
| **Get started** | This README            | [Quickstart →](https://zillapi.com/quickstart/) · [API reference →](https://zillapi.com/api/properties/) · [OpenAPI 3.1 →](https://zillapi.com/openapi.json) |

Base URL: `https://api.zillapi.com/v1`

---

## Connect

- **Website:** [zillapi.com](https://zillapi.com)
- **Quickstart:** [zillapi.com/quickstart](https://zillapi.com/quickstart/)
- **API Reference:** [zillapi.com/api/properties](https://zillapi.com/api/properties/)
- **MCP Setup Guides:** [Claude Desktop](https://zillapi.com/blog/zillow-mcp-claude-desktop/) · [Claude Code](https://zillapi.com/blog/zillow-mcp-claude-code/) · [Cursor](https://zillapi.com/blog/zillow-mcp-cursor/) · [For AI agents](https://zillapi.com/ai-agents/)
- **Contact:** [hello@zillapi.com](mailto:hello@zillapi.com)

---

## MCP Registry

Registry name for the official [Model Context Protocol Registry](https://registry.modelcontextprotocol.io/):

```
com.zillapi/zillow-mcp
```

---

## FAQ

**Is there a public Zillow API in 2026?**
Not an open one — Zillow retired its public API (ZWSID) in 2021, and official access now runs through Bridge Interactive, which is MLS-gated. Zillow MCP provides same-day, self-serve access to Zillow-sourced property data through the Model Context Protocol, with a free tier and no approval process.

**What is a Zillow MCP?**
A Zillow MCP is a Model Context Protocol server that exposes Zillow property data as tools an AI agent can call — property lookup by address or zpid, Zestimates, and listing search — so assistants like Claude, ChatGPT, and Cursor can fetch live U.S. property data mid-conversation.

**How do I add it to Claude Desktop, Claude Code, or ChatGPT?**
Claude Desktop: Settings → Connectors → Add custom connector → paste `https://api.zillapi.com/mcp`. Claude Code: `claude mcp add --transport http zillapi https://api.zillapi.com/mcp --header "Authorization: Bearer zk_YOUR_KEY"`. ChatGPT: enable Developer Mode, then Settings → Connectors → Add MCP server → paste the URL and complete the OAuth prompt. See [Quick Install](#quick-install) for every client.

**Can it run comps or a quick CMA?**
Yes — that's the core workflow. Ask for recently sold homes near a subject property, then compare sale prices, Zestimates, and price per sqft. Agents use it for quick CMAs; investors run the same flow for flip margins and rental yield checks.

**How much does it cost?**
100 free credits at signup with no card. After that it's credit-based — monthly/annual plans or top-ups from $4 per 1,000 credits. Most calls are 1 credit per record; address lookups are 3 credits; failed calls are free.

**Is this affiliated with Zillow?**
No. Zillapi is an independent service and is not affiliated with, endorsed by, or sponsored by Zillow Group, Inc. "Zillow" and "Zestimate" are trademarks of Zillow Group, Inc., used here descriptively to refer to those services.

---

<p align="center">
  <sub>© 2026 Zero Point Studio d.o.o. · Released under the <a href="./LICENSE">MIT License</a></sub>
</p>
