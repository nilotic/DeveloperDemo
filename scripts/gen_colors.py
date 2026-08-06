#!/usr/bin/env python3
"""
디자인 시스템의 Color.xcassets 를 읽어 Swift 소스로 굽는다.

디자인 시스템을 별도 패키지/모듈로 붙이지 않기 때문에 asset symbol 자동 생성을
쓸 수 없다. 데모용으로 색상 값만 하드코딩한 Swift 파일을 만든다.

  사용: python3 gen_colors.py <Color.xcassets 경로> <출력 .swift 경로>
"""
import json
import os
import sys


def channel(raw):
    """components 값 하나를 0~1 Double 로."""
    if isinstance(raw, (int, float)):
        return float(raw)

    raw = raw.strip()
    if raw.startswith("0x") or raw.startswith("0X"):
        return int(raw, 16) / 255.0
    if "." in raw:
        return float(raw)
    return int(raw) / 255.0


def rgba(entry):
    color = entry.get("color")
    if not color:
        return None

    components = color.get("components")
    if not components:
        return None

    alpha = channel(components.get("alpha", 1))

    if "white" in components:
        white = channel(components["white"])
        return (white, white, white, alpha)

    if "red" not in components:
        return None

    return (
        channel(components["red"]),
        channel(components["green"]),
        channel(components["blue"]),
        alpha,
    )


def parse(colorset):
    """(light, dark) 튜플. dark 가 없으면 light 와 동일."""
    with open(os.path.join(colorset, "Contents.json"), encoding="utf-8") as file:
        contents = json.load(file)

    light = None
    dark = None
    fallback = None

    for entry in contents.get("colors", []):
        value = rgba(entry)
        if value is None:
            continue

        appearances = entry.get("appearances")
        if not appearances:
            fallback = fallback or value
            continue

        for appearance in appearances:
            if appearance.get("appearance") != "luminosity":
                continue
            if appearance.get("value") == "dark":
                dark = value
            elif appearance.get("value") == "light":
                light = value

    light = light or fallback
    if light is None:
        return None

    return (light, dark or light)


def main():
    assets, output = sys.argv[1], sys.argv[2]

    tokens = {}
    for base, dirs, _ in os.walk(assets):
        for directory in dirs:
            if not directory.endswith(".colorset"):
                continue
            name = directory[: -len(".colorset")]
            parsed = parse(os.path.join(base, directory))
            if parsed:
                tokens[name] = parsed

    lines = [
        "//",
        "//  Colors.swift",
        "//  DeveloperDemo",
        "//",
        "//  Copyright © 2026 nilotic. All rights reserved.",
        "//",
        "//  자동 생성 파일 — 직접 수정하지 마세요. (DeveloperDemo/scripts/gen_colors.py)",
        "//  디자인 시스템 색상 토큰을 의존성 없이 쓰기 위해 값을 그대로 구워 넣었습니다.",
        "//",
        "",
        "import SwiftUI",
        "import UIKit",
        "",
        "private func designSystemColor(",
        "    light: (CGFloat, CGFloat, CGFloat, CGFloat),",
        "    dark: (CGFloat, CGFloat, CGFloat, CGFloat)",
        ") -> Color {",
        "    Color(UIColor { traits in",
        "        let c = traits.userInterfaceStyle == .dark ? dark : light",
        "        return UIColor(displayP3Red: c.0, green: c.1, blue: c.2, alpha: c.3)",
        "    })",
        "}",
        "",
        "extension Color {",
        "",
    ]

    def literal(value):
        return "(%.4f, %.4f, %.4f, %.4f)" % value

    for name in sorted(tokens):
        light, dark = tokens[name]
        lines.append("    static let %s = designSystemColor(light: %s, dark: %s)" % (name, literal(light), literal(dark)))

    lines += ["}", "", "extension ShapeStyle where Self == Color {", ""]

    for name in sorted(tokens):
        lines.append("    static var %s: Color { .%s }" % (name, name))

    lines += ["}", ""]

    with open(output, "w", encoding="utf-8") as file:
        file.write("\n".join(lines))

    print("%d colors -> %s" % (len(tokens), output))


if __name__ == "__main__":
    main()
