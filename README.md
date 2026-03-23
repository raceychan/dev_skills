# dev_skills

Custom OpenClaw skills repository.

## Migrate skills into the host OpenClaw install

This repo includes a helper script that:

1. Detects the host machine's OpenClaw installation path
2. Resolves the corresponding `skills` directory
3. Copies the skill folders from this repo into that target location

### Usage

```bash
./scripts/migrate-skills.sh
```

### Useful options

```bash
# Preview only
./scripts/migrate-skills.sh --dry-run

# Explicit target
./scripts/migrate-skills.sh --target /opt/homebrew/lib/node_modules/openclaw/skills

# Do not delete files that are not present in this repo
./scripts/migrate-skills.sh --no-delete
```

### Notes

- By default, the script migrates each top-level folder containing a `SKILL.md`.
- It skips non-skill directories such as `.git` and `scripts`.
- It uses `rsync` for synchronization.
