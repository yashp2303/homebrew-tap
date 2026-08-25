# homebrew-tap

Homebrew formulae for my tools.

```bash
brew tap yashp2303/tap
brew install meeting-prd
```

## Formulae

| Formula | What it does |
|---|---|
| [`meeting-prd`](Formula/meeting-prd.rb) | Calendar → Vexa bot → **Groq** → PRD → **Slack approval** → ClickUp. Web app, deployed. |
| [`meeting-to-prd`](Formula/meeting-to-prd.rb) | Calendar → Vexa bot → **Claude** → PRD → ClickUp. Local `brew services` daemon. |

### Which one?

They solve the same problem differently — install either, or both.

|  | `meeting-prd` | `meeting-to-prd` |
| --- | --- | --- |
| Writes the PRD with | Groq | Claude |
| Human approval step | Slack, signed links | none — files directly |
| Where it runs | deployed web app + cron | your Mac, at login |
| Setup | `meeting-prd init` in the terminal | setup page at `127.0.0.1:7717` |
| Source | [meeting-prd](https://github.com/yashp2303/meeting-prd) (public) | [meeting-to-prd](https://github.com/yashp2303/meeting-to-prd) (private) |

Pick `meeting-prd` if you want a review gate before tickets get created, and
something that keeps working when your laptop is shut. Pick `meeting-to-prd`
if you want zero infrastructure and trust it to file straight away.

### Notes

`meeting-to-prd` fetches over git from a private repository, so it needs your
GitHub credentials and a one-time `brew trust yashp2303/tap`. `meeting-prd`
installs from a public release asset and needs neither.

Neither formula ships credentials. Both prompt for them on first run.
