#!/usr/bin/env bash
# One-time root tasks for the jerome.chapron account. Run:  sudo bash ~/.config/macos/sudo-once.sh
set -euo pipefail
[[ $EUID -eq 0 ]] || { echo "run with sudo"; exit 1; }

echo "== 1. Touch ID for sudo =="
if [[ -f /etc/pam.d/sudo_local.template && ! -f /etc/pam.d/sudo_local ]]; then
  sed 's/^#auth/auth/' /etc/pam.d/sudo_local.template > /etc/pam.d/sudo_local
  echo "   enabled via /etc/pam.d/sudo_local"
else
  grep -q pam_tid /etc/pam.d/sudo_local 2>/dev/null && echo "   already enabled" || echo "   template missing, skipped"
fi

echo "== 2. Remove Nix (Determinate installer uninstall) =="
if [[ -x /nix/nix-installer ]]; then
  /nix/nix-installer uninstall --no-confirm
else
  echo "   /nix/nix-installer not found, skipped"
fi
# Belt and braces: strip any leftover Nix hooks from system shell files
for f in /etc/zshrc /etc/zshenv /etc/bashrc /etc/bash.bashrc; do
  [[ -f $f ]] && sed -i '' '/^# Nix$/,/^# End Nix$/d' "$f" && true
done

echo "== 3. Ownership sanity: anything left owned by the legacy user in the home dir =="
find "/Users/jerome.chapron" -user jerome -maxdepth 3 2>/dev/null | head -20 || true
find /opt/homebrew -user jerome 2>/dev/null | head -5 || true

echo "done. Open a new terminal: sudo should now offer Touch ID, and 'ls /nix' should fail."
