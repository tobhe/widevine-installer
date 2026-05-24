# Widevine installer for aarch64 systems

This tool downloads and installs Widevine for aarch64 systems, then wires it
into every installed browser family.

## How it works

A single fixed-up CDM is installed once at `/var/lib/widevine` (the source of
truth). Each browser family is then pointed at it:

| Browser family | Mechanism | Placement |
| --- | --- | --- |
| Native Firefox | `MOZ_GMP_PATH` + system default pref | symlink to `/var/lib/widevine` |
| Native Chromium (Brave, Chrome, Vivaldi, Edge, Opera, …) | per-profile component hint | symlink to `/var/lib/widevine` |
| Snap Firefox | per-profile `user.js` | **copy** into the snap profile |
| Snap Chromium | per-profile component hint | **copy** into the snap profile |

Snaps are strictly confined and cannot read `/var/lib`, so they get real copies;
everyone else gets symlinks, so a single CDM upgrade propagates instantly.

## Usage

```sh
sudo widevine-installer       # download + install system CDM, then wire your browsers
widevine-installer --user     # (no root) re-wire the current user's browsers, e.g.
                              # after installing a new browser. No re-download.
```

Run `--user` again any time you add a browser; it is idempotent.

NOTE: Using Widevine requires glibc version 2.36 or later. Arch Linux ARM ships
an ancient glibc version, and will not work at this time. Most other distros
(even Debian stable) should be OK.

# Credits

Original fixup script by [@DavidBuchanan314](https://github.com/DavidBuchanan314):
https://gist.github.com/DavidBuchanan314/c6b97add51b97e4c3ee95dc890f9e3c8

Changes to support newer CDMs and vanilla glibc and install script by
[@marcan](https://github.com/marcan).
