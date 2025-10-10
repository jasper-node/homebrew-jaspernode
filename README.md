# JasperNode Homebrew Tap

Official Homebrew formula for JasperNode - AI-powered industrial automation runtime.

## Installation

```bash
brew tap jasper-node/jaspernode && brew install jaspernode
```

## Usage

After installation, run:
```bash
jaspernode
```

Use the JasperNode AI Assistant for help and documentation.

## Updating

To update to the latest version:

```bash
brew update && brew upgrade jaspernode
```

## Publishing a New Release

The release script automatically fetches the latest version information and updates the formula:

```bash
deno run --allow-net --allow-read --allow-write --allow-run release.ts
```

Or using the task shortcut:
```bash
deno task release
```

This will:
- Fetch the latest version info from `https://dl.jasperx.io/jn/version`
- Generate the updated `jaspernode.rb` formula
- Commit and push changes to the repository

## Links

- Homepage: https://www.jasperx.com.au/
- Download: https://dl.jasperx.io/jn/
