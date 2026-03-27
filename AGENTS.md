# README and CI maintenance

When making changes that affect how the config works, what it installs, or how it is validated, update **README.md** and/or **.github/workflows/ci.yml** in the same change when needed—do not leave docs or CI stale.

## README.md (`README.md`)

Review and update when you:

- Add, remove, rename, or materially change a **plugin** (the Plugins table and any related prose).
- Add, remove, or change **keybinds** or user-facing behavior (keep aligned with `docs/KEYBINDS.md` if that file is the source of truth; README duplicates or summarizes—keep them consistent).
- Change **requirements** (Neovim version, external tools, Mason/LSP notes, install paths).
- Add or change **ftplugin**, **syntax**, or filetype-specific behavior that users should know about.

Skip README edits for purely internal refactors with no user-visible or documented surface.

## CI (`.github/workflows/ci.yml`)

Review and update when you:

- Introduce new **lint/format** tools or config paths not covered by existing `luacheck` / `stylua` invocations.
- Add **Lua** outside existing layouts if CI should validate it (e.g. new top-level dirs of `.lua` config).
- Change **ftplugin** layout or testing strategy (the job loops `find ./ftplugin -type f -path '*.lua'`).
- Change **Neovim** version expectations or **bootstrap** steps (`Lazy! sync`, healthcheck) if CI should mirror that.
- Add **system packages** or **binary downloads** (e.g. new StyLua version) that CI must install to pass locally-equivalent checks.

If CI steps become redundant or wrong after a change, fix the workflow in the same PR as the code change.

## Quick self-check before finishing

1. Would a new contributor following README be misled? → fix README.
2. Would `master` CI still pass and still reflect what we actually test? → fix CI.
