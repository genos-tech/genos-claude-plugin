# Genos plugin for Claude

Connect Claude to your Genos workspace and teach it how to work there. The plugin bundles:

- **The Genos connector.** Claude reads and changes your Genos tasks, milestones, notes and comments through
  Genos's MCP server at `https://api.genosai.dev/api/public/v1/mcp`. The plugin contains no API key or token.
  You sign in with your own Genos account, and Claude can only do what that account can already do.
- **Three skills.** `genos-workflow` for day-to-day work on tasks, milestones and notes;
  `genos-product-team` for software and product work (branches, pull requests, bugs, releases); and
  `genos-setup` for a first-time workspace setup.

You need a Genos account on a plan that includes the connector: **Core or above**. The first month of Core is
free for new users.

## Install in Claude Code

```
/plugin marketplace add genos-tech/genos-claude-plugin
/plugin install genos@genos
```

Then connect Genos: run `/mcp`, choose **genos**, and sign in. Genos shows its own consent page, which names the
app asking for access and the permissions it requests. Allow access only if you recognize the app.

To try a local copy instead, clone this repository and run `claude --plugin-dir ./plugins/genos`.

## Install in claude.ai or Claude Desktop

1. Download `genos-claude-plugin.zip` from the [latest release](https://github.com/genos-tech/genos-claude-plugin/releases/latest).
2. In claude.ai open **Customize → Plugins**, choose **Add**, and upload the zip. Claude Desktop has the same
   screen under its own **Customize** settings.
3. Open the plugin's **Connectors** tab and choose **Genos**. Sign in and allow access on the Genos consent page.

## Connect any other AI app

Genos lists the connector address under **Settings → Developer → Connect an AI app**. Any client that supports
remote MCP servers can use it. Sign-in uses your Genos account and needs no API key.

## Try it

- "Catch me up on my Genos tasks."
- "Create a task in project PRJ for the login bug, after checking that no duplicate exists."

Claude loads a skill automatically when a request matches its description, and you can also name one directly.
Over this connector Genos does not pause a write for a confirmation card, so the skills tell Claude to ask you
before any change that cannot be undone. Check what Claude is about to do.

## Your data

When you use the plugin, Claude sends your request and the Genos data it needs for that request to the Genos MCP
server, which runs the request with your permissions. The plugin stores no data of its own. You can review or
disconnect a connected app at any time under **Settings → Developer → Connected apps** in Genos; disconnecting
revokes that app's access to your account. See the Genos privacy policy at <https://genosai.dev/privacy>.

## Updates

Update the plugin from the marketplace (`/plugin marketplace update genos`), or install a newer zip from the
releases page. Each release is tagged with its version.

## Repository layout

| Path | What it is |
| --- | --- |
| `.claude-plugin/marketplace.json` | The marketplace that lists the plugin |
| `plugins/genos/` | The plugin: manifest, connector address, skills |
| `genos-claude-plugin.zip` | Built by the release workflow on each version tag; not stored in the repository |

## License

MIT. See [LICENSE](LICENSE).
