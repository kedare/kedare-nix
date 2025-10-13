# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix` defines inputs and the `nixosConfigurations` set for each machine; treat it as the single source of truth for what builds.
- Host-specific logic lives under `hosts/<hostname>/`, typically split into `configuration.nix` and `hardware.nix`. Keep any new host files in the same pattern.
- Shared modules belong in `modules/`, grouped by domain (`core/global`, `core/desktop`, `devenv`, `gaming`). Prefer adding reusable options here rather than duplicating host config.
- Generated outputs such as the `result` symlink are ephemeral; do not commit them.

## Build, Test, and Development Commands
- `task lint` — format every `.nix` file with `nixfmt`.
- `task build` — evaluate and build the configuration for `HOSTNAME`, showing traces on failure.
- `task switch` — apply the current host build (requires sudo); use only after a successful `task build`.
- `task update` — refresh inputs and rewrite `flake.lock`; run this in dedicated commits.
- `nixos-rebuild build --flake .#<host>` — fallback when `task` is unavailable, useful for CI or bootstrap.

## Coding Style & Naming Conventions
- Run `nixfmt` before committing; the project expects two-space indentation and tidy attribute alignment.
- Name modules and attributes in lowercase with hyphens where needed (e.g., `modules/core/server/virtualization.nix`); keep host directories lowercase.
- Keep imports explicit and grouped at the top of each module; avoid inline lambdas when a `let` binding improves readability.
- Never commit secrets; reference external key sources the way `modules/core/global/users.nix` fetches SSH keys.

## Testing Guidelines
- Treat a green `task build` (or `nixos-rebuild build`) as the minimum confidence bar for every touched host.
- For stateful changes, exercise `nixos-rebuild test --flake .#<host>` to stage services without switching.
- Capture important manual checks in your PR description so reviewers can reproduce them quickly.
- There is no automated coverage gate; if you add modules, document how you validated them.

## Commit & Pull Request Guidelines
- Follow the existing history: short, imperative subject lines such as `add rootless docker`; keep 72-character soft wraps.
- Squash WIP commits before review, and isolate unrelated refactors into separate commits.
- PRs should describe affected hosts/modules, list validation commands run, and link to any relevant issues or tracking notes.
- Request review from maintainers of touched areas and call out follow-up work so it can be scheduled.
