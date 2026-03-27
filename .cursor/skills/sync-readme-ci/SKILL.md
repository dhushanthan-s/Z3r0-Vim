---
name: sync-readme-ci
description: >-
  Updates README.md and .github/workflows/ci.yml when Neovim config changes affect
  user-facing documentation or CI validation. Use when editing plugins, keybinds,
  requirements, ftplugin or syntax, luacheck or stylua setup, Lazy bootstrap,
  Neovim version in CI, GitHub Actions steps, or system/binary dependencies for
  checks in this repository.
---

# Sync README and CI with config changes

After substantive edits in this repo, decide whether **README.md** and/or **.github/workflows/ci.yml** need updates in the same change. Do not leave docs or CI stale.

## README.md

Review and update when you:

- Add, remove, rename, or materially change a **plugin** (Plugins table and related prose).
- Add, remove, or change **keybinds** or user-facing behavior (keep consistent with `docs/KEYBINDS.md` when that file is the source of truth).
- Change **requirements** (Neovim version, external tools, Mason/LSP notes, install paths).
- Add or change **ftplugin**, **syntax**, or filetype-specific behavior users should know about.

Skip README updates for internal refactors with no user-visible or documented surface.

## `.github/workflows/ci.yml`

Review and update when you:

- Introduce new **lint/format** tools or config paths not covered by existing `luacheck` / `stylua` invocations.
- Add **Lua** in new locations if CI should validate those paths.
- Change **ftplugin** layout or testing strategy (the job uses `find ./ftplugin -type f -path '*.lua'`).
- Change **Neovim** version expectations or **bootstrap** steps (`Lazy! sync`, `checkhealth`) that CI should mirror.
- Add **system packages** or **binary downloads** (e.g. StyLua version) that CI must install for checks to match local development.

Fix redundant or obsolete workflow steps in the same change as the code that makes them wrong.

## Finish checklist

1. Would a new contributor following README be misled? If yes, update README.
2. Would `master` CI still pass and still reflect what is actually tested? If no, update the workflow.
