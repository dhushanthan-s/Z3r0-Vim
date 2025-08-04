-- .luacheckrc
std = "luajit"
globals = {
  "vim",
  "require",
  "use",
}
unused_args = false

exclude_files = {
  "plugin/packer_compiled.lua",
  "lazy-lock.json"
}
