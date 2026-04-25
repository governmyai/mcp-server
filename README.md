# @governmyai/mcp-server

GovernMy.ai MCP server — query AI governance obligations from Claude Desktop, Cursor, or any MCP-compatible client.

Covers EU AI Act, ISO 42001, Colorado AI Act, NIST AI RMF, HIPAA (AI provisions), SOX (AI provisions), and FTC AI guidance.

## What this does

This MCP server gives an AI assistant (like Claude) the ability to query GovernMy's rules engine directly while you're working. You can ask questions like:

- *"What EU AI Act obligations apply if I build a hiring AI for the EU?"*
- *"Which frameworks does this cover?"*
- *"What evidence do I need for EU AI Act Article 10 data governance?"*
- *"Does my ISO 42001 Clause 6 work also cover any NIST AI RMF functions?"*

...and get structured regulatory obligations back as part of the conversation.

**Important:** this tool returns **obligations**, not verdicts. It never tells you "you're compliant" or "you're not compliant" — those are determinations only a human reviewer can make. Every response includes a `humanReviewRequired` flag where applicable.

## Copy-paste into Claude

After installing + restarting, try one of these:

- *"What are the mandatory-review obligations for a high-risk hiring AI deployed in the EU?"*
- *"Show me the evidence requirements for EU AI Act Articles 11 and 14."*
- *"Compare EU AI Act and Colorado AI Act obligations for a credit-scoring AI."*
- *"Does my HR chatbot trigger any regulatory obligations? It does resume screening."*
- *"What ISO 42001 Annex A controls do I need for a generative AI system?"*
- *"Which NIST AI RMF dimensions does EU AI Act Art. 10 data governance also satisfy?"*
- *"I'm building a medical imaging AI — what obligations apply under HIPAA AI provisions?"*
- *"List every obligation flagged as `cannotBeAutoSatisfied` across all frameworks."*

## Install + configure (Claude Desktop)

1. Register for an API key at https://governmy.ai/developers (free tier available)
2. Open your Claude Desktop config file:
   - macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`
   - Windows: `%APPDATA%\Claude\claude_desktop_config.json`
3. Add the GovernMy server to your `mcpServers` object:

```json
{
  "mcpServers": {
    "governmy": {
      "command": "npx",
      "args": ["-y", "@governmyai/mcp-server"],
      "env": {
        "GOVERNMY_API_KEY": "ooa_live_your_key_here"
      }
    }
  }
}
```

4. Restart Claude Desktop. Ask Claude: *"What governance frameworks does GovernMy cover?"* — it should call the `list_frameworks` tool.

## Install + configure (Cursor)

Add the server to your Cursor MCP settings (Settings → MCP Servers):

- Command: `npx`
- Args: `-y @governmyai/mcp-server`
- Environment: `GOVERNMY_API_KEY=ooa_live_your_key_here`

## Configure (other MCP clients)

Any client that speaks stdio MCP can run this server. Set `GOVERNMY_API_KEY` in the client's env for the server process.

## Environment variables

| Variable | Required | Default | Purpose |
|---|---|---|---|
| `GOVERNMY_API_KEY` | yes | — | Your GovernMy.ai API key |
| `GOVERNMY_API_URL` | no | `https://api.governmy.ai` | Override API base URL (for local dev) |

## Tools exposed

- **`get_obligations`** — query obligations that apply to an AI system given context (risk tier, role, industry, etc.)
- **`classify_risk_tier`** — classify an AI system's EU AI Act risk tier (unacceptable / high / limited / minimal)
- **`list_frameworks`** — list the frameworks the engine covers with metadata
- **`get_rule`** — fetch the full payload for a single obligation by id
- **`get_evidence_requirements`** — fetch required evidence artifacts for a set of obligations
- **`get_cross_references`** — fetch cross-framework mappings for an obligation

Every tool response includes a `notAVerdict` notice reminding the AI assistant that obligations are not compliance verdicts.

## What this is not

- **Not legal advice.** The rules engine is a research tool + workflow accelerator. Compliance decisions require qualified human review.
- **Not a replacement for a compliance professional.** If your AI system is materially exposed to any of the covered frameworks, pair this with a real compliance program.
- **Not a verdict engine.** We deliberately do not return "compliant: true" or "allowed: true". This is both an ethical line and a legal one (EU AI Act Art. 14).

## Support

- Docs: https://docs.governmy.ai/mcp
- API reference: https://docs.governmy.ai/api
- Issues: https://github.com/governmyai/mcp-server/issues
- Email: hello@governmy.ai

## License

MIT
