from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any


PREFIX = "axotris.ax:"


def move_prefixed_entries_to_bottom(value: Any) -> tuple[Any, bool]:
    """Recursively move matching string entries to the bottom of every JSON list."""
    changed = False

    if isinstance(value, list):
        updated_items = []
        for item in value:
            updated_item, item_changed = move_prefixed_entries_to_bottom(item)
            updated_items.append(updated_item)
            changed = changed or item_changed

        normal_items = [
            item
            for item in updated_items
            if not (isinstance(item, str) and item.startswith(PREFIX))
        ]
        prefixed_items = [
            item
            for item in updated_items
            if isinstance(item, str) and item.startswith(PREFIX)
        ]
        reordered = normal_items + prefixed_items

        return reordered, changed or reordered != value

    if isinstance(value, dict):
        updated_object = {}
        for key, item in value.items():
            updated_item, item_changed = move_prefixed_entries_to_bottom(item)
            updated_object[key] = updated_item
            changed = changed or item_changed

        return updated_object, changed

    return value, False


def process_json_file(path: Path) -> bool:
    with path.open("r", encoding="utf-8") as file:
        data = json.load(file)

    updated_data, changed = move_prefixed_entries_to_bottom(data)
    if not changed:
        return False

    with path.open("w", encoding="utf-8", newline="\n") as file:
        json.dump(updated_data, file, ensure_ascii=False, indent=2)
        file.write("\n")

    return True


def iter_json_files(script_dir: Path, recursive: bool) -> list[Path]:
    pattern = "**/*.json" if recursive else "*.json"
    return sorted(path for path in script_dir.glob(pattern) if path.is_file())


def main() -> int:
    parser = argparse.ArgumentParser(
        description=(
            "Moves all JSON list entries starting with "
            f"{PREFIX!r} to the bottom of their respective list."
        )
    )
    parser.add_argument(
        "--recursive",
        action="store_true",
        help="Also process JSON files in subfolders of the script directory.",
    )
    args = parser.parse_args()

    script_dir = Path(__file__).resolve().parent
    json_files = iter_json_files(script_dir, args.recursive)

    changed_count = 0
    for path in json_files:
        if process_json_file(path):
            changed_count += 1
            print(f"Updated: {path.relative_to(script_dir)}")

    print(f"Processed {len(json_files)} JSON file(s), updated {changed_count}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
