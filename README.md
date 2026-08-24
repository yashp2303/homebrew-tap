# homebrew-tap

Homebrew formulae for my tools.

```bash
brew tap yashp2303/tap
brew trust yashp2303/tap      # Homebrew 6 requires this for third-party taps
brew install meeting-to-prd
```

`brew trust` is required once per tap — Homebrew 6 will not load a formula from
an untrusted third-party tap. These repos are private, so formulae fetch over
git using your existing GitHub credentials.

## Formulae

| Formula | What it does |
|---|---|
| [`meeting-to-prd`](Formula/meeting-to-prd.rb) | Turns meetings into ClickUp tickets — Calendar → Vexa bot → Claude → PRD → ClickUp |
