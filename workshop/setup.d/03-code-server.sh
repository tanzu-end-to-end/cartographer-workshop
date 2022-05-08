#!/bin/bash
set -x
set +e

cat <<'EOF' > /home/eduk8s/.local/share/code-server/User/settings.json
{
    "redhat.telemetry.enabled": false,
    "terminal.integrated.automationShell.linux": "/bin/bash",
    "workbench.startupEditor": "none",
    "update.showReleaseNotes": false,
    "python.autoUpdateLanguageServer": false,
    "extensions.autoCheckUpdates": false,
    "extensions.autoUpdate": false,
    "update.mode": "none",
    "python.linting.enabled": false
}
EOF
