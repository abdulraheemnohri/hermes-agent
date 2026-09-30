---
sidebar_position: 2.5
title: "Platform Support"
description: "Termux-focused platform support for this repository."
---

# Platform Support

This checkout is intentionally maintained as a **Termux / Android aarch64-focused source tree**. Apple macOS, native Windows, Electron/Desktop, MSIX, PowerShell installers, and their dedicated CI/package assets are not shipped here.

## Supported target

| Target | Status | Installation |
| --- | --- | --- |
| **Android / Termux (aarch64)** | Primary target | Official signed Hermes Termux package + `termux-tensor/` |

## Runtime boundary

- Hermes remains the agent/orchestration layer.
- `termux-tensor/` provides the Google Tensor / local-runtime profile.
- LiteRT-LM native binaries are optional and must be compatible with Android/Termux.
- GGUF + `llama-server` is the local HTTP fallback.
- CPU inference is the baseline; Tensor GPU/NPU acceleration is not assumed merely because a device contains a Tensor SoC.
- Background execution is best-effort because Android may terminate Termux processes.

## Removed from this checkout

- Apple macOS application and bundle packaging
- Windows native installer, PowerShell setup, and MSIX/App Installer assets
- Electron desktop application
- Desktop build/update pipelines
- Windows/macOS-only test suites and CI lanes

Keep new platform work inside the Termux/Android runtime boundary rather than reintroducing desktop packaging.
