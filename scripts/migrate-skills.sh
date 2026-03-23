#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

log() {
  printf '[migrate-skills] %s\n' "$*"
}

warn() {
  printf '[migrate-skills] WARN: %s\n' "$*" >&2
}

usage() {
  cat <<'EOF'
Usage:
  migrate-skills.sh [--target DIR] [--source DIR] [--dry-run] [--no-delete]

Options:
  --target DIR   Explicit target skills directory.
  --source DIR   Explicit source directory. Default: repo root.
  --dry-run      Show what would be copied without changing files.
  --no-delete    Do not delete target entries that are absent in source.
  -h, --help     Show help.

Behavior:
  - Detects the host OpenClaw installation location.
  - Resolves the corresponding OpenClaw skills directory.
  - Copies all skill folders from this repository into that directory.

Examples:
  ./scripts/migrate-skills.sh
  ./scripts/migrate-skills.sh --dry-run
  ./scripts/migrate-skills.sh --target /opt/homebrew/lib/node_modules/openclaw/skills
EOF
}

DRY_RUN=0
DELETE_MODE=1
SOURCE_DIR="$REPO_ROOT"
TARGET_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET_DIR="${2:?missing value for --target}"
      shift 2
      ;;
    --source)
      SOURCE_DIR="${2:?missing value for --source}"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --no-delete)
      DELETE_MODE=0
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      warn "Unknown argument: $1"
      usage >&2
      exit 1
      ;;
  esac
done

resolve_openclaw_install_root() {
  local candidate=""

  if command -v openclaw >/dev/null 2>&1; then
    candidate="$(command -v openclaw)"
    while [[ -L "$candidate" ]]; do
      local linked
      linked="$(readlink "$candidate")"
      if [[ "$linked" = /* ]]; then
        candidate="$linked"
      else
        candidate="$(cd "$(dirname "$candidate")" && cd "$(dirname "$linked")" && pwd)/$(basename "$linked")"
      fi
    done

    local resolved_dir
    resolved_dir="$(cd "$(dirname "$candidate")" && pwd)"

    case "$resolved_dir" in
      */node_modules/openclaw/bin)
        printf '%s\n' "$(cd "$resolved_dir/.." && pwd)"
        return 0
        ;;
      */openclaw/bin)
        printf '%s\n' "$(cd "$resolved_dir/.." && pwd)"
        return 0
        ;;
    esac
  fi

  for candidate in \
    "/opt/homebrew/lib/node_modules/openclaw" \
    "/usr/local/lib/node_modules/openclaw" \
    "$HOME/.nvm/versions/node"/*/lib/node_modules/openclaw \
    "$HOME/.volta/tools/image/node"/*/lib/node_modules/openclaw \
    "$HOME/.asdf/installs/nodejs"/*/.npm/lib/node_modules/openclaw
  do
    [[ -d "$candidate" ]] || continue
    printf '%s\n' "$candidate"
    return 0
  done

  return 1
}

if [[ -z "$TARGET_DIR" ]]; then
  INSTALL_ROOT="$(resolve_openclaw_install_root || true)"
  if [[ -z "$INSTALL_ROOT" ]]; then
    warn "Could not detect OpenClaw installation path automatically."
    warn "Pass --target <skills_dir> manually."
    exit 1
  fi
  TARGET_DIR="$INSTALL_ROOT/skills"
else
  INSTALL_ROOT="$(cd "$TARGET_DIR/.." 2>/dev/null && pwd || true)"
fi

[[ -d "$SOURCE_DIR" ]] || { warn "Source directory not found: $SOURCE_DIR"; exit 1; }
mkdir -p "$TARGET_DIR"

SKILL_DIRS=()
while IFS= read -r line; do
  [[ -n "$line" ]] && SKILL_DIRS+=("$line")
done < <(
  find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -type d \
    ! -name '.git' \
    ! -name 'scripts' \
    ! -name '.github' \
    ! -name '.idea' \
    ! -name '.vscode' \
    -exec test -f '{}/SKILL.md' ';' -print | sort
)

if [[ ${#SKILL_DIRS[@]} -eq 0 ]]; then
  warn "No skill directories found under source: $SOURCE_DIR"
  exit 1
fi

RSYNC_ARGS=(-a)
if [[ $DELETE_MODE -eq 1 ]]; then
  RSYNC_ARGS+=(--delete)
fi
if [[ $DRY_RUN -eq 1 ]]; then
  RSYNC_ARGS+=(--dry-run --itemize-changes)
fi

log "Source repo: $SOURCE_DIR"
if [[ -n "$INSTALL_ROOT" ]]; then
  log "Detected OpenClaw install: $INSTALL_ROOT"
fi
log "Target skills dir: $TARGET_DIR"
log "Skills to migrate:"
for dir in "${SKILL_DIRS[@]}"; do
  printf '  - %s\n' "$(basename "$dir")"
done

for dir in "${SKILL_DIRS[@]}"; do
  name="$(basename "$dir")"
  log "Syncing $name"
  rsync "${RSYNC_ARGS[@]}" \
    --exclude '.DS_Store' \
    --exclude '.git' \
    --exclude 'node_modules' \
    "$dir/" "$TARGET_DIR/$name/"
done

if [[ $DRY_RUN -eq 1 ]]; then
  log 'Dry run complete. No files were changed.'
else
  log 'Migration complete.'
fi
