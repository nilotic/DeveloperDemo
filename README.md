# DeveloperDemo

A standalone demo app built from an in-app developer menu.

## Overview

The app has two tabs, Home and More. The developer menu lives under **More → Developer**.
Home is a placeholder screen.

| Group | Screens |
|---|---|
| Networking | Hosts, Signature |
| Push | Local push, Remote push |
| Account | JSON web token, Email allowlist, Account lock, Account deletion |
| Link | Deeplink |
| UI | Color palette, Color picker, Typography, Image content mode |
| UX | Haptics |
| Configuration | App icon |

Three screens need third-party SDKs and ship as placeholders instead: social account
information, seasonal event, and feature flags. See `DeveloperDemo/Developer/Placeholder/`.

Hosts and endpoints on the network-backed screens — account lock, account deletion,
email allowlist, and remote push — are placeholder values and do not resolve.

## Layout

```
DeveloperDemo/
  App/                  App shell — tab setup and the home screen
  Developer/            Developer menu screens
  Util/                 Networking, account, domain, and utilities
  DesignSystem/         Components and color tokens
  Assets.xcassets
  Localizable.xcstrings
scripts/
  gen_colors.py         Generates Swift color tokens from a Color.xcassets
  generate_project.rb   Regenerates the Xcode project
```

Each feature folder follows the same shape: `<Name>View.swift`, `<Name>Data.swift`,
and `View/` and `Model/` subfolders.

Files are registered in the project individually, so regenerate the project after
adding or removing a source file.

```
ruby scripts/generate_project.rb   # requires the xcodeproj gem
```

`DeveloperDemo/DesignSystem/Colors.swift` is generated. Rerun `scripts/gen_colors.py`
instead of editing it by hand.
